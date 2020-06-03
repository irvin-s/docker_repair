FROM nitnelave/nvidia
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v3/cudnn-7.0-linux-x64-v3.0-prod.tgz -O && \
      tar -xzf cudnn-7.0-linux-x64-v3.0-prod.tgz -C /usr/local && \
      rm cudnn-7.0-linux-x64-v3.0-prod.tgz && \
      ldconfig
