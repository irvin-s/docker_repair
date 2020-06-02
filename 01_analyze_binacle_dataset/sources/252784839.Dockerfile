FROM codekoala/arch  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN pacman -Sqyu --noconfirm --needed openssh && \  
systemctl enable sshd  
  
# configure ssh  
RUN sed -i \  
-e 's/^#*\\(PermitRootLogin\\) .*/\1 yes/' \  
-e 's/^#*\\(PasswordAuthentication\\) .*/\1 yes/' \  
-e 's/^#*\\(PermitEmptyPasswords\\) .*/\1 yes/' \  
-e 's/^#*\\(UsePAM\\) .*/\1 no/' \  
/etc/ssh/sshd_config  
  
EXPOSE 22  
CMD ["/usr/bin/init"]  

