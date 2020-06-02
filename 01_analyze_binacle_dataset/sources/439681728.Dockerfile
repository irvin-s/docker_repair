FROM nitnelave/nvidia
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v5/cudnn-7.5-linux-x64-v5.0-rc.tgz -O && \
    tar -xzf cudnn-7.5-linux-x64-v5.0-rc.tgz -C /usr/local && \
    rm cudnn-7.5-linux-x64-v5.0-rc.tgz && \
    ldconfig
