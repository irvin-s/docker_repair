FROM python:3  
  
run pip install awscli --upgrade  
run apt-get update  
run apt-get -y install zip  

