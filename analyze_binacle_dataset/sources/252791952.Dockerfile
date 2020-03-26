FROM ubuntu  
MAINTAINER Takashi Takebayashi <changesworlds@gmail.com>  
  
# Install packages for JDK, Scala, npm, Node.js  
# Update-alternative nodojs to node  
# Update npm  
# Install sbt  
# Install the agent installer  
# Create Agent  
RUN apt-get update && \  
apt-get install -y --force-yes \  
curl \  
default-jdk \  
git \  
nodejs \  
npm \  
scala \  
wget && \  
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \  
npm install npm -g && \  
wget https://dl.bintray.com/sbt/debian/sbt-0.13.9.deb && \  
apt-get update && \  
dpkg -i sbt-0.13.9.deb && \  
sbt && \  
npm install -g vsoagent-installer && \  
mkdir /opt/myagent && \  
cd /opt/myagent && \  
vsoagent-installer && \  
echo "vsoagent\nvsoagent\n\n\n\n\n\n\n" | adduser vsoagent && \  
chown -R vsoagent /opt/myagent  
  
WORKDIR /opt/myagent  
ENTRYPOINT /bin/bash  

