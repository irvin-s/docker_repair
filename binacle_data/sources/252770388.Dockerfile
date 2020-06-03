FROM ubuntu:16.04  
RUN apt-get update -y  
RUN apt-get install -y \  
build-essential \  
curl \  
git \  
python \  
wget \  
xz-utils  
RUN apt-get install -y curl wget xz-utils  
  
# Install Nodejs  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash  
RUN apt-get install -y nodejs  
  
# Install Gatsby  
RUN npm install -g gatsby-cli  
  
RUN mkdir -p /app  
WORKDIR /app  
  
EXPOSE 3000/tcp  
EXPOSE 8000/tcp  

