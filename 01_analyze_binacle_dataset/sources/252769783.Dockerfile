FROM ubuntu:16.04  
# install packages needed by fahclient installer  
RUN apt-get update && apt-get install -y bzip2  
  
# install fahclient  
ADD add/fahclient_7.4.4_amd64.deb .  
RUN dpkg -i fahclient_7.4.4_amd64.deb  
RUN rm -rf *.deb  
  
# configure it  
RUN mv /etc/fahclient/config.xml /etc/fahclient/config.xml.orig  
ADD add/config.xml /etc/fahclient  
  
# cleanup  
RUN rm -rf /var/lib/apt/lists/*  
  
# go to homedir  
WORKDIR /var/lib/fahclient  
  
# environment variables  
ENV FAHCLIENT_POWER light  
ENV FAHCLIENT_PASSKEY ""  
ENV FAHCLIENT_TEAM ""  
ENV FAHCLIENT_USER ""  
# expose port for monitoring  
EXPOSE 36330  
EXPOSE 7396  
# entrypoint  
ADD docker-entrypoint.sh /  
RUN chmod u+x /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]  

