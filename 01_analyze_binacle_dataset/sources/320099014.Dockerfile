FROM python:3.5-alpine

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --update --no-cache ca-certificates gcc g++ curl openblas-dev@community

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN pip3 install --no-cache-dir --disable-pip-version-check numpy==1.11.0 scipy==0.18.0 scikit-learn==0.18.1
