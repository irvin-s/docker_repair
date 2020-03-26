# sample docker file for tensorflow-gpu inference, training tensorflow models
#
# but first:
#
# ================================ install docker ================================
# > sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# > # on 14.04:
# > sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
# > # on 16.04:
# > sudo echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
# > sudo apt-get update
# > apt-cache policy docker-engine
# > sudo apt-get install linux-image-extra-$(uname -r)
# > sudo apt-get install docker-engine
# > # if the command above fails:
# > sudo apt-get install docker-ce
# > sudo groupadd docker
# > sudo usermod -a -G docker <user who will use docker>
# > sudo service docker start
#
# ================================ configure network, if required ================================
# > # add or edit "bip" value in your /etc/docker/daemon.json, so that it looks as something like:
# > cat /etc/docker/daemon.json
# {
#     "bip": "192.168.2.1/24",
#     "runtimes": {
#         "nvidia": {
#             "path": "/usr/bin/nvidia-container-runtime",
#             "runtimeArgs": []
#         }
#     }
# }
#
# > # restart docker service
# > sudo systemctl restart docker.service
#
# ================================ install nvidia docker ================================
# > # if you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
# > docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
# > sudo apt-get purge -y nvidia-docker
# 
# > # add the package repositories
# > curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
# > distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
# > curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
# > sudo apt-get update
#  
# > # install nvidia-docker2
# > sudo apt-get install -y nvidia-docker2
#  
# > # stop docker
# > sudo service docker stop
# > # ...or more radically
# > sudo pkill -SIGHUP dockerd
# > # start docker and reload the Docker daemon configuration
# > sudo service docker start
#  
# test nvidia-smi with the latest official CUDA image
# > docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi


FROM tensorflow/tensorflow:latest-gpu

# =================== installing tensorflow-gpu sufficient for inference ===================

RUN apt-get update \
        && apt-get install -y --no-install-recommends git python-pip python-dev \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
 
RUN pip install --upgrade setuptools pip
RUN pip --no-cache-dir install numpy tensorflow-gpu \
        && python -m ipykernel.kernelspec

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           ca-certificates \
           build-essential \
           git \
           python \
           python-pip \
           python-setuptools \
           python-tk

# tf-nightly-gpu breaks tensorflow import; do we need it at all? it seems that it is needed only for tensorflow nightly builds
#RUN pip install tf-nightly-gpu

# =================== installing pretrained models and training dependencies ===================

# currently seem to work at tag 7367d494135368a7790df6172206a58a2a2f3d40
# rm -rf .git: since git history is not required in this container, remove it to reduce the container image size
RUN    git clone https://github.com/tensorflow/models.git /root/src/tensorflow_models \
    && cd /root/src/tensorflow_models \
    && rm -rf .git
#    && git reset --hard 0f5803bdfced0cae02300e355e9415e96bb3383c \
#    && rm -rf .git

RUN    mkdir -p /root/.local/lib/python2.7/site-packages \
    && ( echo /root/src/tensorflow_models/research/; echo /root/src/tensorflow_models/research/slim ) > /root/.local/lib/python2.7/site-packages/tensorflow_models.pth

# install protobuf compiler 3.3.0 by hand, until available in apt-get (currently apt-get install 2.6.x)
#RUN   apt-get install protobuf-compiler
RUN    curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip \
    && unzip protoc-3.3.0-linux-x86_64.zip -d protoc3 \
    && mv protoc3/bin/* /usr/local/bin/ \
    && mv protoc3/include/* /usr/local/include/ \
    && cd /root/src/tensorflow_models/research && protoc object_detection/protos/*.proto --python_out=. \
    && pip install --user .

# =================== 'installing' snark tensorflow utilities for convenience ===================

# quick and dirty: for convenience, just copy tensor-cat and tensor-calc rather than properly installing comma and snark
RUN    mkdir -p /root/src \
    && cd /root/src \
    && git clone https://github.com/acfr/comma.git \
    && echo /root/src/comma/python > /root/.local/lib/python2.7/site-packages/comma.pth \
    && git clone https://github.com/acfr/snark.git \
    && cp /root/src/snark/machine_learning/deep_learning/tensorflow/applications/tensor-cat /root/src/snark/machine_learning/deep_learning/tensorflow/applications/tensor-calc /usr/local/bin
