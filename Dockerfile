FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

## Variables/arguments that can be set by the user.
ARG INIT_COMMAND
ARG CXX

## Setting CXX to be the default C++ compiler of the docker.
ENV CXX=$CXX

## Bring system into a consistent initial state.
RUN apt-get update && apt-get full-upgrade -y && apt-get autoremove -y
RUN apt-get install -y apt-utils wget

## Install packages needed for HyperHDG.
RUN apt-get install -y git doxygen graphviz cmake cython3 libblas-dev liblapack-dev ipython3 $CXX
RUN apt-get install -y libgl1-mesa-dev xvfb
# RUN apt-get install -y python3-dev python3-numpy python3-scipy python3-pip

## Define global variables of the docker.
RUN mkdir src src/volatile
WORKDIR src/
COPY . ./volatile

## Install jupyter-xeus/xeus-cling.
ENV PATH="/root/miniconda/bin:$PATH"
# Download and install the latest version of Miniconda.
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p ~/miniconda && rm ~/miniconda.sh
# Install numpy, scipy, xeus-cling and jupyter.
RUN conda create -n cling && conda install -c conda-forge numpy pip scipy xeus-cling jupyter pyvista
RUN pip install ipyvtk-simple

## Fix pyvista and Miniconda issues with jupyter.
ENV DISPLAY=:99.0
ENV PYVISTA_OFF_SCREEN=true
ENV PYVISTA_USE_IPYVTK=true

## Run some initializing command.
RUN $INIT_COMMAND

## Define the purpose of the docker container.
CMD which Xvfb && Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 & sleep 3 \
  && jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root
