FROM phusion/baseimage

RUN apt-get update && apt-get -y install python python-jinja2 nginx python-requests && apt-get clean
EXPOSE 80
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.service /etc/service/nginx/run
ADD config.service /etc/service/build-config/run
ADD build-config.py /
