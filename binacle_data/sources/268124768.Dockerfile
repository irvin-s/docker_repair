FROM tensorflow/tensorflow

ADD https://github.com/alexellis/faas/releases/download/0.5.5-alpha/fwatchdog /usr/bin
ADD http://download.tensorflow.org/models/image/imagenet/inception-2015-12-05.tgz /tmp/

RUN mkdir /tmp/imagenet
RUN tar -xvf /tmp/inception-2015-12-05.tgz -C /tmp/imagenet/
RUN mv /tmp/inception-2015-12-05.tgz /tmp/imagenet/inception-2015-12-05.tgz
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /root/
COPY images images

COPY index.py           .
COPY requirements.txt   .
RUN pip install -r requirements.txt

COPY function           function

RUN touch ./function/__init__.py

WORKDIR /root/function/
COPY function/requirements.txt	.
RUN pip install -r requirements.txt

WORKDIR /root/

ENV fprocess="python index.py"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
