FROM stackbrew/ubuntu:13.10  
MAINTAINER DerMitch <michael@dermitch.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
#ADD http://192.168.2.21/01proxy /etc/apt/apt.conf.d/01proxy  
# Make sure we have the latest and greatest libraries  
RUN apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y;  
  
# Install base tools  
RUN apt-get install -y python-dev python-pip git  
  
# Headers required for all python packages  
RUN apt-get install -y libffi-dev libevent-dev liblzma-dev libssl-dev  
  
# Now install and configure the registry  
RUN git clone https://github.com/dotcloud/docker-registry.git /app  
WORKDIR /app  
ADD config.yml /app/config/config.yml  
RUN pip install -r requirements.txt  
  
# Should be same as in config.yml  
VOLUME ["/var/lib/docker-registry"]  
  
EXPOSE 5000  
CMD /app/run.sh  

