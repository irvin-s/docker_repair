FROM ubuntu:latest
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe">/etc/apt/sources.list
RUN apt-get update && apt-get install php5 php5-mysql  php5-mhash -y #php5-mcrypt mysql-server
ADD . /app
