FROM bryanlatten/dcos-jenkins-dind-agent:0.5.0-alpine  
  
RUN apk add --upgrade py-pip make  
RUN pip install --upgrade awscli docker-compose  

