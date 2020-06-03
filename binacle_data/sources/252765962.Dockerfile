# Basics  
#  
FROM ubuntu:16.04  
MAINTAINER wenzizone <wenzizone@126.com>  
  
# install deps  
#RUN apk add --no-cache --virtual .build-deps \  
# bash-completion \  
# curl \  
# tar \  
# xmlstarlet \  
# openjdk8  
RUN apt-get update && \  
apt-get install -y xmlstarlet openjdk-8-jre curl  
  
# Install Crowd  
ENV CROWD_VERSION 2.12.0  
ENV CROWD_CONTEXT crowd  
ENV CROWD_DATA /opt/atlassian-home/crowd  
  
ADD common.bash /usr/local/share/atlassian/common.bash  
RUN chmod 644 /usr/local/share/atlassian/common.bash  
#ADD splash-context.xml /opt/crowd/webapps/splash.xml  
ADD launch.bash /launch  
RUN chmod +x /launch  
ADD provision.bash /provision  
RUN chmod +x /provision  
  
#COPY crowd.tar.gz /root/  
RUN ["/provision"]  
  
# Launching Crowd  
WORKDIR /opt/crowd  
VOLUME ["/opt/atlassian-home"]  
EXPOSE 8095  
USER crowd  
CMD ["/launch"]  

