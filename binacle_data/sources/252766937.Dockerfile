FROM debian:jessie  
MAINTAINER Albert Dixon <albert@timelinelabs.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install --no-install-recommends -y build-essential nginx \  
python python-dev python-pip  
RUN pip install envtpl  
RUN apt-get remove -y --purge build-essential python-dev &&\  
apt-get autoremove -y && apt-get autoclean -y &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN rm -f /etc/nginx/nginx.conf  
COPY configs/* /etc/nginx/  
COPY scripts/* /usr/local/bin/  
RUN chmod a+rx /usr/local/bin/* &&\  
mkdir /nginx  
  
WORKDIR /etc/nginx  
ENTRYPOINT ["docker-start"]  
EXPOSE 80 443  
ENV PATH /usr/local/bin:$PATH  
ENV WORKER_PROCESSES 2  
ENV WORKER_CONNECTIONS 24  
ENV LOG_FILE nginx.log  
ENV LOG_LEVEL info

