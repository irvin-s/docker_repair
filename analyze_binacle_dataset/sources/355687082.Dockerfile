FROM ubuntu:16.04
MAINTAINER Gary Yang <garyyang@purestorage.com>; Cary Li <cary.li@purestorage.com>

# Expose a web endpoint for the management website
EXPOSE 8080

RUN apt-get update && apt-get install -y rabbitmq-server python-pip python-dev vim nodejs-legacy npm curl
RUN pip install Celery==3.1.18
RUN pip install purestorage==1.11.0
RUN pip install gevent==1.1.2
RUN pip install Flask==0.12.1
RUN pip install elasticsearch==5.4.0
RUN pip install python-dateutil==2.4.2
RUN pip install enum34==1.0.4
RUN npm install elasticdump@0.15.0

ENV target_folder /pureelk
ADD container/ $target_folder
ADD conf/logrotate-pureelk.conf /etc/logrotate.d/pureelk
WORKDIR $target_folder

RUN chmod +x start.sh
RUN mkdir -p /var/log/pureelk

# Run the startup script. Also run a long running process to prevent docker from existing. 
CMD ./start.sh && exec tail -f /etc/hosts

