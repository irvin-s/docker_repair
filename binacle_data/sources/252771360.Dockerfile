FROM node:latest  
MAINTAINER ajaysreedhar468@gmail.com  
  
RUN apt-get update && apt-get upgrade -y && apt-get install supervisor -y  
  
RUN mkdir /opt/portfolio-api  
  
COPY src /opt/portfolio-api/src  
COPY .eslintrc.json /opt/portfolio-api/.eslintrc.json  
COPY .gitignore /opt/portfolio-api/.gitignore  
COPY README.md /opt/portfolio-api/README.md  
COPY package.json /opt/portfolio-api/package.json  
COPY entrypoint.sh /opt/portfolio-api/entrypoint.sh  
  
COPY supervisord.conf /etc/supervisor/supervisord.conf  
  
RUN cd /opt/portfolio-api && npm install  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  
  
EXPOSE 80  

