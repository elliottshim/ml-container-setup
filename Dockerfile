# Load Ubuntu 18.04 disk image
# FROM ubuntu:18.04

# Load Ubuntu 18.04 w/Cuda 10.2
FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04


# Add Anaconda 3 to environment path variable
ENV PATH="/root/anaconda3/bin:${PATH}"
ARG PATH="/root/anaconda3/bin:${PATH}"


RUN apt update \
    && apt install -y wget htop python3-dev 

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh \
    && mkdir root/.conda \
    && sh Anaconda3-2021.05-Linux-x86_64.sh -b \
    && rm -f Anaconda3-2021.05-Linux-x86_64.sh

RUN conda create -y -n myenv python=3.7

# Copy current working directory and put in docker container folder src/
COPY . src/

# Install packages in requirements.txt and pytorch
RUN /bin/bash -c "cd src \
    && source activate myenv \
    && pip install -r requirements.txt \
    && conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch"