FROM docker:1.9.1  
  
RUN apk update && apk add git openssh python groff nodejs perl  
  
# set up github key  
RUN mkdir ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts  
  
# install awscli  
RUN curl -O https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py  
RUN pip install awscli boto3  

