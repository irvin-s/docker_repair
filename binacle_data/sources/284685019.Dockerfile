# GPU enabled Docker container to run QANet

FROM tensorflow/tensorflow:1.5.1-gpu

RUN mkdir /home/QANet
ADD requirements.txt /home/QANet
RUN pip install -r /home/QANet/requirements.txt

# Set the default directory where CMD will execute
WORKDIR /home/QANet

RUN apt-get update && apt-get install -y wget unzip

# https://github.com/keras-team/keras/issues/9567
RUN apt-get install -y --allow-downgrades --no-install-recommends libcudnn7=7.0.5.15-1+cuda9.0 libcudnn7-dev=7.0.5.15-1+cuda9.0 && rm -rf /var/lib/apt/lists/*

RUN apt-get update