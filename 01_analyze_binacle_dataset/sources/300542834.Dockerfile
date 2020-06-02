FROM tensorflow/tensorflow:1.1.0-gpu-py3
RUN apt-get update
RUN apt-get install -y python3-tk
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r ./requirements.txt
RUN echo "LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu_custom'" >> ~/.profile
RUN echo "LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu_custom'" >> ~/.bashrc
COPY ./ /app
