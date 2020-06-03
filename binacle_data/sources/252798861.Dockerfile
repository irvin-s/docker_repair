FROM ubuntu:xenial  
  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
openjdk-8-jdk \  
&& useradd -m jenkins  
  
WORKDIR /home/jenkins  
USER jenkins  
COPY start.sh .  
  
CMD [ "/home/jenkins/start.sh" ]  

