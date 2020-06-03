FROM fedora/apache:latest  
  
LABEL version="1.0"  
LABEL description="The frontend of my Homeautomatizaion"  
  
EXPOSE 443  
# install packages  
RUN dnf -y update && dnf -y install \  
httpd \  
mod_ssl \  
npm \  
&& dnf clean all  
  
# fix httpd config  
RUN sed -i.orig 's/#ServerName/ServerName/' /etc/httpd/conf/httpd.conf  
  
WORKDIR /usr/src/app  
COPY package.json /usr/src/app/  
RUN npm install  
COPY . /usr/src/app/  
  
#WORKDIR /var/www/frontend  
CMD ["/usr/src/app/docker-run.sh"]  

