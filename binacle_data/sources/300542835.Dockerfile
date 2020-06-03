FROM tensorflow/tensorflow:1.1.0-py3
RUN apt-get update
RUN apt-get install -y python3-tk
WORKDIR /app
COPY ./checkpoints /app/checkpoints
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r ./requirements.txt
COPY ./cyclegan.py /app/
COPY ./image.py /app/
COPY ./imagecache.py /app/
COPY ./utils.py /app/
COPY ./prediction.py /app/
COPY ./server.py /app/



