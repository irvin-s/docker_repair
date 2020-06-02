#FROM ubuntu:14.04  
FROM chin33z/build-host-config  
  
MAINTAINER David Hu <chin33z@gmail.com>  
  
RUN cd ~ && sed -i 's/Port 22/Port 55556/g' /etc/ssh/sshd_config &&\  
sed -i 's/David Hu/Wayne Chou/g' dotfiles/gitconfig &&\  
sed -i 's/chin33z@gmail.com/waynechou@qnap.com/g' dotfiles/gitconfig  
  
EXPOSE 55556  
# CMD ["/root/dotfiles/fuse_setup.sh"]  

