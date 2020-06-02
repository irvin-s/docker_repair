FROM stackbrew/ubuntu:12.04
RUN apt-get update -qq && apt-get install -y python python-pip
ADD . /code/
WORKDIR /code
RUN python setup.py install
