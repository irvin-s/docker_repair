FROM ubuntu:14.04

RUN apt-get update && apt-get install -y python \
    python-pip \
    python-dev \
    python-opencv \
    python-pyquery \
    python-flask

RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp27-none-linux_x86_64.whl

RUN ln /dev/null /dev/raw1394

WORKDIR /data/

CMD ["python", "captcha_app.py"]