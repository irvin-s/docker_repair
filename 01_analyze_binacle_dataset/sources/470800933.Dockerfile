FROM tensorflow/tensorflow:1.9.0
#FROM tensorflow/tensorflow:1.9.0-gpu

WORKDIR /

COPY ./images /images
COPY ./distributedretrain.py /distributedretrain.py

ENTRYPOINT [ "python","distributedretrain.py" ]