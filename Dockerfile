####################################################################################################
# Dockerfile for a docker container including a Jupyter notebook that can deal with Python and C++
# codes. The notebook is run on a local Ubuntu and can be variably adapted.
#
# Author: Andreas Rupp, Heidelberg University, 2021.
####################################################################################################


## Set the image this docker is based on and make build process non-interactive.
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive


## Variable/argument that can be set by the user.
ARG INIT_COMMAND


## Setup Jupyter Notebook/Lab that can deal with C++ and Python using Miniconda.

# Install packages needed to install Miniconda and fix its visualization issues.
RUN apt-get update && apt-get install -y wget libgl1-mesa-dev xvfb && rm -rf /var/lib/apt/lists/*

# Set path to Miniconda installation.
ENV PATH="/root/miniconda/bin:$PATH"

# Download and install the latest version of Miniconda.
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
  && bash ~/miniconda.sh -b -p ~/miniconda && rm ~/miniconda.sh

# Install pip, numpy, scipy, xeus-cling, jupyter, and pyvista. Afterwards, install ipyvtk-simple.
RUN conda install -c conda-forge pip numpy scipy xeus-cling jupyterlab pyvista nodejs \
  && pip install ipyvtk-simple itkwidgets && conda clean --all -f -y

# Add necessary extensions for interactive output to Jupyter Lab.
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib \
  jupyterlab-datawidgets itkwidgets

# Define environments needed to fix the visualization issues of Anaconda's Python.
ENV DISPLAY=:99.0
ENV PYVISTA_OFF_SCREEN=true
ENV PYVISTA_USE_IPYVTK=true


## Copy local files to Docker image.
RUN mkdir src
WORKDIR src/
COPY . .


## Run some initializing command.
RUN apt-get update && eval $INIT_COMMAND && apt-get clean && rm -rf /var/lib/apt/lists/*


## Define the command for starting the docker container: First line fixes visualization issues.
CMD which Xvfb && Xvfb :99 -screen 0 1600x1200x24 > /dev/null 2>&1 & \
  sleep 5  && jupyter lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root & \
  sleep 10 && echo "\nPlease, save the last shown URL and especially its token!" && \
  echo "If you stop and re-start the container, you will need URL and/or token to login." && \
  echo "Alternatively, you can set a password and only have to remember it and the URL.\n" && \
  echo "Note that Ctrl+C does not work, although this is stated differently above.\n" && \
  echo "You can use the Jupyter notebook by visiting the last displayed URL.\n" && sleep infinity
