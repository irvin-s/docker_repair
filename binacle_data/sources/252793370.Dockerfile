#FROM ubuntu:14.04  
#FROM debian:unstable  
FROM chin33z/build-host-config  
  
MAINTAINER David Hu <chin33z@gmail.com>  
  
RUN cd ~ && sed -i 's/Port 22/Port 55555/g' /etc/ssh/sshd_config  
EXPOSE 55555  
# CMD ["/root/dotfiles/fuse_setup.sh"]  

