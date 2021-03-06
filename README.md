# ml-container-setup

Quickly setup containers for machine learning projects using Docker and Anaconda3.  

## Prerequisites

- Debian-based linux system with Nvidia GPU
- Nvidia drivers installed in host OS (verify using nvidia-smi command)



## Stack

We will be creating a virtual environment using Docker (Docker image) with the following stack:
- Ubuntu 18.04
- CUDA
- Nvidia-Docker
- Anaconda 3
- Pytorch / Jupyter / Other libraries (as defined in requirements.txt)

## Installation

Download requirements.txt and Dockerfile. Add necessary packages and their versions in requirements.txt (these will be installed via Anaconda) and add necessary programs in Dockerfile. Then run the following commands in order. 

Install and enable Docker

```sh
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

Setup Nvidia Container Toolkit
```sh
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

Install Nvidia Docker
```sh
sudo apt-get update
sudo apt-get install -y nvidia-docker2
```

Restart Docker
```sh
sudo systemctl restart docker
```

Switch to directory with Dockerfile, then build and run the Dockerfile

```sh
cd directory
docker build -t mytag .
```

Run the Dockerfile 
```sh
# Run without GPU passthrough
docker run -ti mytag bash 
# Run with GPU passthrough 
docker run -ti --gpus all mytag bash 
```

## Accessing Jupyter from Remote Server
Run the following commands:
Local port forwarding using -L flag
```sh
ssh -L 8000:localhost:8000 user@000.000.00.00
```
Run container with local folder mounted to docker container folder. Example below shows path to local folder named stack1 mounted to a newly created folder stack1 in the Docker container's root directory. Files in local directory show up in the root directory of Docker container.
```shf
sudo nvidia-docker run -v /root/docker_envs/stack1:/root/stack1 -it -p 8000:8000 mytag bash
```
Activate conda environment
```shf
source activate myenv
```


Open Jupyter Notebook, copy and paste Jupyter URL into browswer, and enjoy your new workflow!
```sh
jupyter notebook --ip 0.0.0.0 --port 8000 --allow-root
```
