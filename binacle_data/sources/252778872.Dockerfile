FROM node:4.3  
  
RUN apt-get update \  
&& apt-get install rsync zip -y \  
&& npm install aws-sdk node-lambda -g

