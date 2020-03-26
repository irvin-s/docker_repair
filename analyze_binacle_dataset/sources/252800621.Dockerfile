FROM debian:jessie  
  
COPY . /go/src/github.com/bobrik/collectd-docker  
COPY . /comapi/  
COPY collectd-rabbitmq /opt/collectd-plugins/collectd-rabbitmq  
RUN apt-get update  
RUN apt-get -y install sudo  
RUN apt-get -y install curl  
RUN apt-get -y install nano  
RUN apt-get -y install python  
RUN apt-get -y install python-pip  
RUN apt-get -y install git  
RUN apt-get -y install build-essential python-dev  
RUN easy_install collectd-rabbitmq  
RUN apt-get -y install libpython2.7  
RUN apt-get -y install python-pymongo  
RUN python -m easy_install pymongo  
RUN chmod +x /go/src/github.com/bobrik/collectd-docker/docker/build.sh  
RUN chmod +x /go/src/github.com/bobrik/collectd-docker/docker/run.sh  
  
RUN ["/go/src/github.com/bobrik/collectd-docker/docker/build.sh"]  
  
RUN chmod +x /run.sh  
  
COPY collectd.conf /etc/collectd/collectd.conf  
COPY types.db /opt/collectd-plugins/types.db  
COPY mongodb.py /opt/collectd-plugins/mongodb.py  
  
ENTRYPOINT ["/run.sh"]  

