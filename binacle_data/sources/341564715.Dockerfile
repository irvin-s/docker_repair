FROM golang:1.6

RUN apt-get update -yqq \
	&& apt-get install -y build-essential python-pip unzip ruby \
	&& pip install awscli \
	&& gem install bundler cfoo