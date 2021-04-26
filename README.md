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

    sudo docker run -p 8888:8888 <tag>

resulting in an output similar to

````
/usr/bin/Xvfb
[I 2021-04-26 15:56:33.451 ServerApp] jupyterlab | extension was successfully linked.
[I 2021-04-26 15:56:33.460 ServerApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/jupyter_cookie_secret
[I 2021-04-26 15:56:33.618 ServerApp] nbclassic | extension was successfully linked.
[I 2021-04-26 15:56:33.654 LabApp] JupyterLab extension loaded from /root/miniconda/lib/python3.8/site-packages/jupyterlab
[I 2021-04-26 15:56:33.654 LabApp] JupyterLab application directory is /root/miniconda/share/jupyter/lab
[I 2021-04-26 15:56:33.656 ServerApp] jupyterlab | extension was successfully loaded.
[I 2021-04-26 15:56:33.660 ServerApp] nbclassic | extension was successfully loaded.
[I 2021-04-26 15:56:33.660 ServerApp] Serving notebooks from local directory: /src
[I 2021-04-26 15:56:33.660 ServerApp] Jupyter Server 1.6.4 is running at:
[I 2021-04-26 15:56:33.660 ServerApp] http://60d03d07f085:8888/lab?token=9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221
[I 2021-04-26 15:56:33.660 ServerApp]     http://127.0.0.1:8888/lab?token=9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221
[I 2021-04-26 15:56:33.660 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2021-04-26 15:56:33.663 ServerApp]
    
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-7-open.html
    Or copy and paste one of these URLs:
        http://60d03d07f085:8888/lab?token=9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221
        http://127.0.0.1:8888/lab?token=9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221

Please, save the last shown URL and especially its token!
If you stop and re-start the container, you will need URL and/or token to login.
Alternatively, you can set a password and only have to remember it and the URL.

Note that Ctrl+C does not work, although this is stated differently above.

You can use the Jupyter notebook by visiting the last displayed URL.
````

Importantly, the full output is displayed approximately 10 seconds after hitting enter and this is
also the time, the notebook takes to start, so to speak. You will need the last given URL and token
to access the notebook. Thus,

> URL: http://127.0.0.1:8888/lab?token=9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221  
> token: 9a34da197309b509955b172ef545d5cf0fefcc1c8eccd221

You can access the notebook using the full URL or using `http://127.0.0.1:8888/` and inserting the
token. Alternatively, you can use the token to set a password and use the password in the future.
However, we recommend you to save both URL and token.

We also recommend you to inform about the `docker container start/stop` commands to (re-)use your
notebook. Enjoy!
