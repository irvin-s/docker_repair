FROM python:3.6
MAINTAINER Yohei Kikuta <yohei-kikuta@cookpad.com>

# Set up envirnment.
RUN apt-get update && apt-get install -y \
    libmysqlclient-dev \
    graphviz \
    mecab \
    libmecab-dev \
    mecab-ipadic \
    mecab-ipadic-utf8

# Install python modules.
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create an unser, assuming ubuntu user id is 1000.
RUN useradd docker -u 1000 -s /bin/bash -m
USER docker

# Set working directory.
WORKDIR /work

CMD ["jupyter", "notebook", "--port", "8888", "--ip", "0.0.0.0", "--no-browser"]
