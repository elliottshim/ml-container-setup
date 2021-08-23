# Load Ubuntu 18.04 w/Cuda 10.2
FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04
WORKDIR /src


# Add Anaconda 3 to environment path variable
ENV PATH="/root/anaconda3/bin:${PATH}"
ARG PATH="/root/anaconda3/bin:${PATH}"

RUN apt update \
    && apt install -y wget htop python3-dev ffmpeg libsm6 libxext6

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh \
    && sh Anaconda3-2021.05-Linux-x86_64.sh -b \
    && rm -f Anaconda3-2021.05-Linux-x86_64.sh

# Copy current working directory and put in docker container folder src/
COPY . src/

COPY ./environment.yml /src/enviornment.yml
RUN conda env create -n myenv -f src/environment.yml && \
    conda clean --all --yes

# Install conda packages
COPY conda-requirements.txt /src/conda-requirements.txt
RUN conda install -n myenv -c conda-forge --file conda-requirements.txt

SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Install non-conda packages
COPY requirements.txt /src/requirements.txt
RUN pip install -r requirements.txt
