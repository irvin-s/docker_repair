FROM debian:jessie  
MAINTAINER buddyspike <buddyspike@geeksdiary.com> (@buddyspike)  
  
RUN apt-get update && \  
apt-get install curl -y && \  
apt-get install git -y && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install nodejs -y && \  
mkdir microbit && \  
cd microbit && \  
npm install -g pxt && \  
pxt target microbit && \  
apt-get clean  
  
EXPOSE 80 443  
WORKDIR microbit  
  
ENTRYPOINT ["pxt", "serve", "-h", "0.0.0.0", "--noBrowser"]  

