FROM node:4  
MAINTAINER Amin Jams <aminjam@outlook.com>  
  
RUN apt-get update  
RUN npm install -g bower grunt-cli node-gyp  
  
# Install Supervisor  
RUN apt-get -qy install supervisor  
  
# Add configurations  
ADD supervisord-app.conf /etc/supervisor/conf.d/supervisord-app.conf  
ADD run.sh /run.sh  
ADD start-app.sh /start-app.sh  
RUN chmod +x /*.sh  
  
##################### INSTALLATION END #####################  
RUN echo 'node:' `node --version` 'npm' `npm --version`  
EXPOSE 3001  
WORKDIR /home/app  
CMD ["/run.sh"]  

