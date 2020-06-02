FROM nginx  
MAINTAINER Alex Belozerov "asbelozerov@gmail.com"  
# Install NodeJS 4, npm and roots  
RUN apt-get update -y  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get install -y nodejs  
RUN apt-get install -y git  
RUN npm install roots@3.1.0 -g  
  
ADD staticsite-deploy.sh /usr/local/sbin/staticsite-deploy.sh  
RUN chmod 755 /usr/local/sbin/staticsite-deploy.sh  
  
EXPOSE 80 443  
CMD ["/usr/local/sbin/staticsite-deploy.sh"]

