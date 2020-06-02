FROM ubuntu:14.04
RUN apt-get -y update
RUN sudo apt-get -y install python-dev python-pip build-essential git libpq-dev
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENV SERVER_NAME app-elb-1864513316.us-east-1.elb.amazonaws.com
