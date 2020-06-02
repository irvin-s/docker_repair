FROM bassoman/nodejs  
MAINTAINER Jon Lancelle <bassoman@gmail.com>  
  
RUN npm install -g nodemon bower grunt  
  
RUN apt-get install -y python-pip python-virtualenv python-setuptools  
  
RUN easy_install virtualenv  
  
# allow bower to run nicely as root user  
RUN echo '{ "allow_root": true }' > /root/.bowerrc  

