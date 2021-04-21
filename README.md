# Docker container for a Jupyter notebook that can deal with C++ and Python codes

The Dockerfile can be used to build a [Docker](https://www.docker.com/) image of a Jupyter notebook
that runs on a Ubuntu image and can deal with C++ and Python scripts. To this end, [xeus-cling](
https://github.com/jupyter-xeus/xeus-cling) is used and its visualization issues are bypassed as
explained in the [pyvista guide](https://docs.pyvista.org/getting-started/installation.html).

The docker container can be build (on Linux) using a comand like

    sudo docker build --build-arg INIT_COMMAND="<command>" -f <path> -t <tag> .

Here, `command` can be some bash command such as `apt-get install -y git && setup.sh` (no sudo,
since you are root in this phase) installing `git` and executing script `setup.sh`, afterwards. The
`<path>` is the local path to the `Dockerfile` and `<tag>` defines a tag for he Docker image. Note
that `setup.sh` needs to be located in the directory in which the command is executed or its local
path needs to be prefixed. The build process may take several (around 5 to 10) minutes.

Having built the Docker image, the Docker container may be run using e.g.

    sudo docker run -p 8888:8888 hyperhdg_docker

resulting in an output similar to

````
/usr/bin/Xvfb
[I 14:04:24.615 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[I 14:04:24.773 NotebookApp] Serving notebooks from local directory: /src
[I 14:04:24.773 NotebookApp] Jupyter Notebook 6.3.0 is running at:
[I 14:04:24.773 NotebookApp] http://f3239cc6d4ce:8888/?token=9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430
[I 14:04:24.773 NotebookApp]  or http://127.0.0.1:8888/?token=9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430
[I 14:04:24.774 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 14:04:24.776 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-8-open.html
    Or copy and paste one of these URLs:
        http://f3239cc6d4ce:8888/?token=9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430
     or http://127.0.0.1:8888/?token=9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430

Please, save the last shown URL and especially its token!
If you stop and re-start the container, you will need URL and/or token to login.
Alternatively, you can set a password and only have to remember it and the URL.

Note that Ctrl+C does not work, although this is stated differently above.
````

Importantly, the full output is displayed approximately 10 seconds after hitting enter and this is
also the time, the notebook takes to start, so to speak. You will need the last given URL and token
to access the notebook. Thus,

> URL: http://127.0.0.1:8888/?token=9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430
> token: 9bf95d4356b260462c76ff00d0fbbbd890d28a5ddc42c430

You can access the notebook using the full URL or using `http://127.0.0.1:8888/` and inserting the
token. Alternatively, you can use the token to set a password and use the password in the future.
However, we recommend you to save both URL and token.

We also recommend you to inform about the `docker container start/stop` commands to (re-)use your
notebook. Enjoy!
