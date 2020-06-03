FROM ubuntu:latest  
  
MAINTAINER Damien LAGAE <damienlagae@gmail.com>  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y software-properties-common  
  
RUN add-apt-repository -y ppa:transmissionbt/ppa && \  
apt-get update && \  
apt-get install -y transmission-daemon  
  
RUN mkdir -p /transmission/incomplete && \  
mkdir /etc/transmission  
  
ADD files/settings.json /etc/transmission/settings.json  
ADD files/start /start  
  
EXPOSE 51413  
EXPOSE 9091  
  
VOLUME ["/transmission"]  
  
RUN chown -R daemon /transmission && \  
chown -R daemon /etc/transmission  
  
USER daemon  
  
CMD ["/start"]  

