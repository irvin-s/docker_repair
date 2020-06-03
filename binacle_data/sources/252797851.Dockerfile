FROM java:openjdk-8-jdk  
  
MAINTAINER Jason Webb jason@jswebb.net  
  
ENV AGENT_DIR /opt/buildAgent  
VOLUME /opt/buildAgent  
  
ADD teamcity-entrypoint.sh /teamcity-entrypoint.sh  
RUN chmod +x /teamcity-entrypoint.sh  
  
# Build dependencies  
RUN apt-get update \  
&& apt-get -y install vim sudo curl  
  
# TeamCity User  
RUN adduser --disabled-password --gecos "" teamcity \  
&& sed -i -e "s/%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/" /etc/sudoers \  
&& usermod -a -G sudo teamcity  
  
EXPOSE 9090  
ENTRYPOINT ["/teamcity-entrypoint.sh"]

