FROM alpine:3.5  
RUN apk add --update --no-cache openssh && \  
adduser -D -s /sbin/nologin -H tunnel && \  
sed -i s/tunnel:!:/tunnel:*:/ /etc/shadow  
  
COPY sshd_config /etc/ssh/sshd_config  
COPY entrypoint.sh /entrypoint.sh  
  
RUN chmod 0700 /entrypoint.sh && \  
chmod 0400 /etc/ssh/sshd_config  
  
EXPOSE 2222  
CMD ["/entrypoint.sh"]  

