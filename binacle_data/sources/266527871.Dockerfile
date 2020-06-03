FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2-RC

MAINTAINER nuculur@gmail.com

ENV ARCH=aarch64

# install ubuntu python releases
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests python-minimal python-pip libpython-dev wget \ 
 && apt-get install -y --no-install-recommends --no-install-suggests build-essential \
 && apt-get install -y --no-install-recommends --no-install-suggests python-setuptools python-all-dev python-dev \
 && apt-get -y autoremove && apt-get clean

# get precompiled TF 1.6 for JetPack 3.2 RC
WORKDIR /tmp/
# Obtained Tensorflow wheel from: https://github.com/NVIDIA-Jetson/tf_to_trt_image_classification/tree/master#install
COPY py27/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl /tmp/tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl
RUN pip install --no-cache-dir --upgrade pip && pip install tensorflow-1.5.0rc0-cp27-cp27mu-linux_aarch64.whl

# Add hello.py, the TF validation script
WORKDIR /app
ADD hello.py /app/

# Run validation script if you choose
#CMD [ "/usr/bin/python", "/app/hello.py"]

# For docker --squash build
RUN rm -rf /tmp/*
