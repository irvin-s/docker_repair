FROM tensorflow/tensorflow:1.11.0-devel-gpu-py3
RUN pip install sacred
RUN pip install opencv-python
RUN apt install -y libsm6 libxrender1 libxext6 tmux
RUN apt-get update
RUN apt-get install -y openssh-server
WORKDIR /tmp
