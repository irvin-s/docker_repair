
FROM alpine
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.it>"

RUN apk update && apk upgrade && apk add \
    python3 \
    curl wget \
    && rm -rf /var/cache/apk/* && \
    wget https://bootstrap.pypa.io/ez_setup.py -O - | python3 && \
    easy_install-3.5 pip

RUN pip --no-cache-dir install --no-cache-dir \
    httpie
