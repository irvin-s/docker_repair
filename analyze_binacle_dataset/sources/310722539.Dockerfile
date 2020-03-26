from paddlepaddle/book:latest-gpu

RUN apt update
RUN apt install python-opencv -y

RUN pip install tensorflow
RUN pip install keras
RUN pip install np_utils
RUN pip install h5py

