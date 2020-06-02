FROM pytorch/pytorch:1.0-cuda10.0-cudnn7-runtime 

COPY . /root/example

WORKDIR /root/example

RUN pip install pip -U && pip install -r requirements.txt
