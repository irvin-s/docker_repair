FROM jetbrains/teamcity-agent:latest  
  
RUN apt-get update  
RUN apt-get -y --force-yes install \  
apt-transport-https \  
ca-certificates \  
curl \  
software-properties-common  
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  
RUN apt-key fingerprint 0EBFCD88  
RUN add-apt-repository \  
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \  
$(lsb_release -cs) \  
stable"  
RUN apt-get update  
RUN apt-get -y --force-yes install \  
docker-ce \  
gradle \  
python3 \  
python3-pip  
  
RUN pip3 install --upgrade pip  
RUN pip3 install docker \  
boto3 \  
awscli \  
ecs-deploy  

