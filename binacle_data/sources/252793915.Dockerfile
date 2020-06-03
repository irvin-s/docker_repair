FROM docker:17.06.0-ce-git  
  
RUN apk add \--update python python-dev py-pip build-base jq && \  
pip install --upgrade awscli && \  
aws configure set default.output json  

