FROM alpine:3.7  
RUN apk --update add openssh  
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config  
RUN mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/  
RUN rm -rf /var/cache/apk/* /tmp/*  
  
EXPOSE 22  
COPY entrypoint.sh /usr/local/bin/  
  
ENTRYPOINT ["entrypoint.sh"]  

