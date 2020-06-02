FROM alpine:3.1  
RUN apk --update add git openssh bash perl  
  
ADD run.sh /run.sh  
RUN echo " IdentityFile /bazooka-key" >> /etc/ssh/ssh_config  
RUN echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config  
  
CMD ["/run.sh"]  

