FROM ubuntu:latest  
MAINTAINER lucas@rufy.com  
  
RUN apt-get update && apt-get install -y python  
ADD https://www.dropbox.com/download?plat=lnx.x86_64 /dropbox.tgz  
ADD https://www.dropbox.com/download?dl=packages/dropbox.py /bin/dropbox  
RUN chmod +x /bin/dropbox  
RUN tar xfvz /dropbox.tgz && rm /dropbox.tgz  
  
CMD /.dropbox-dist/dropboxd  

