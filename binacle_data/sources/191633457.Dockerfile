FROM ubuntu:trusty

MAINTAINER <stephane.rault@radicalspam.org>

ENV MMS_SERVER mongo-quarantine
#ENV MMS_REAL_RCPT 1
ENV MMS_HOST 0.0.0.0
ENV MMS_PORT 14001
ENV MMS_TIMEOUT 600
ENV MMS_DATA_SIZE_LIMIT 0
ENV MMS_MONGODB_URI mongodb://localhost/message
ENV MMS_MONGODB_DATABASE message
ENV MMS_MONGODB_COLLECTION message
#ENV MMS_DEBUG 1

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  git \
  curl \
  language-pack-en \
  python-dev \
  cython \
  python-gevent
  
ENV PATH /usr/local/bin:${PATH}
ENV LANG en_US.UTF-8

RUN curl -k -O https://bootstrap.pypa.io/ez_setup.py && python ez_setup.py --insecure && rm -f ez_setup.py setuptools*zip

RUN curl -k -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm -f get-pip.py

ADD . /code/

WORKDIR /code/

RUN pip install .

EXPOSE 14001

ENTRYPOINT ["/usr/local/bin/mongo-mail-server"]
CMD ["start"]
