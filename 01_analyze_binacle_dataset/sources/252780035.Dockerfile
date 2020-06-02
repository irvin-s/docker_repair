FROM alpine  
  
RUN apk add --no-cache rsync openssh openssh-client  
  
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /etc/ssh/ssh_config \  
&& ssh-keygen -A \  
&& sed -i -e 's/^.\?PermitRootLogin.*/PermitRootLogin yes/' \  
-e 's/^.\?PasswordAuthentication.*/PasswordAuthentication no/' \  
/etc/ssh/sshd_config  
  
COPY entrypoint.sh /usr/local/bin  
  
ENTRYPOINT [ "entrypoint.sh" ]  

