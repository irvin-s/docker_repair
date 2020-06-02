# This dockerfile is used to run the autostew webserver  
FROM ubuntu:14.04  
Maintainer Michael Wittig <witmic1@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY dependencies.sh dependencies.sh  
  
# install all dependencies  
RUN ./dependencies.sh  
  
# export Standard SSH port  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

