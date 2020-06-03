FROM fedora:latest  
MAINTAINER donny@fortnebula.com  
RUN dnf -y install nodejs npm git  
ADD . /app  
WORKDIR /app  
RUN cd /app && npm install  
EXPOSE 8000  
CMD [ "npm", "start" ]  

