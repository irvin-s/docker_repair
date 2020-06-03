FROM debian:jessie  
MAINTAINER cocuh <cocuh.kk at gmail.com>  
  
RUN apt-get update -y \  
&& apt-get upgrade -y  
RUN apt-get install -y python3-minimal \  
&& apt-get install -y python3-pip  
RUN mkdir -p /usr/src/app \  
&& mkdir -p /var/run/typowriter/  
WORKDIR /usr/src/app  
  
COPY requirements.txt /usr/src/app/  
COPY uwsgi.ini /usr/src/app/  
RUN pip3 install -r requirements.txt  
  
COPY app /usr/src/app  
  
CMD ["uwsgi", "--chdir", "/usr/src/app", "--ini", "uwsgi.ini"]  

