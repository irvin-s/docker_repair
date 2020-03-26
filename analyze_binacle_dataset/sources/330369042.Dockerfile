FROM tensorflow/tensorflow:1.5.0-gpu-py3

RUN apt-get update && \
    apt-get install -y \
    libsm6 \
    libxext6 \
    libxrender1 \
    libfontconfig1 \
    git

RUN pip install \
        opencv-contrib-python \
        mtcnn \
        imutils \
        https://storage.googleapis.com/morghulis/libs/object-detection-1.4.1/slim-0.1.tar.gz \
        git+https://github.com/the-house-of-black-and-white/morghulis.git@e4b0b0f

WORKDIR /usr/src/app

#ADD . .
