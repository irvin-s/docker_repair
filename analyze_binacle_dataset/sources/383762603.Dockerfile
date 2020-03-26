FROM ubuntu

RUN apt-get upgrade

RUN apt-get update

RUN apt-get install -y python2.7 python-setuptools git

WORKDIR /opt

RUN git clone https://github.com/aydantasdemir/altin.git

WORKDIR /opt/altin

RUN python2.7 setup.py install

ENTRYPOINT ["altin"]
