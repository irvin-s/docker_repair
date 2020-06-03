FROM alpine:latest
MAINTAINER Cat.1 docker@gansi.me

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main" > /etc/apk/repositories
RUN apk update

RUN apk add --no-cache python3 wget && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple  --upgrade pip setuptools && \
    rm -r /root/.cache 


RUN apk add python-dev python3-dev

ENV LC_ALL=zh_CN.UTF-8
ENV PYTHONIOENCODING=utf-8

RUN mkdir -p /freeFileServer/
ADD requirements.txt /freeFileServer/
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple -r /freeFileServer/requirements.txt

ADD freeFileServer.py /freeFileServer/
WORKDIR /freeFileServer

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    chmod +x ./mc && cp ./mc /bin/ 

# RUN mc config host add minio http://118.126.93.123:9000 $ACCESSKEY $SECRETKEY

EXPOSE 65527

CMD python3 ./freeFileServer.py



