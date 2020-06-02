FROM node:9.11.1  
# update and upgrade packages  
RUN apt-get update -yq && apt-get upgrade -yq  
  
# Install GIT  
RUN apt-get install -yq bash git openssh-server  
  
# Install Python  
RUN apt-get install -yq python-pip python-dev build-essential  
  
# Install AWS EB CLI  
RUN pip install --upgrade pip  
RUN pip install awsebcli --upgrade --user  
# Tidy up  
# TODO  
# Add CLI to PATH  
ENV PATH "$PATH:~/.local/bin"  
# Install NestJS CLI  
RUN yarn global add @nestjs/cli@5.1.1  

