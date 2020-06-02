FROM maven:3.5.0-jdk-8  
  
RUN apt-get update && apt-get -y install \  
python \  
python-pip \  
&& pip install boto3==1.3.0 \  
&& pip install awscli  
  

