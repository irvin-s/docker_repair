#Basing on apache because need it to expose files for sparql load.
FROM httpd:latest
MAINTAINER Justin Littman <justinlittman@gwu.edu>

RUN apt-get update && apt-get install -y \
    python-dev \
    python-pip \
    lib32z1-dev \
    libxml2-dev \
    libxslt1-dev \
    git
#Upgrade pip
RUN pip install -U pip
#This pre-fetches the most recent requirements.txt.
ADD https://github.com/gwu-libraries/vivo-load/raw/master/requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
ENV LC_ALL C.UTF-8
WORKDIR /usr/local/vivo-load
VOLUME ["/usr/local/vivo/graphs"]
CMD pip install -r requirements.txt --upgrade && httpd -DFOREGROUND
