FROM circleci/python:2.7-browsers  
  
LABEL maintainer="samuel.gratzl@datavisyn.io"  
LABEL description="This is a base image for python testing"  
LABEL vendor="The Caleydo Team"  
LABEL version="1.0"  
  
# install node  
RUN (curl -sL https://deb.nodesource.com/setup_6.x | sudo bash - ) \  
&& sudo apt-get install -y nodejs

