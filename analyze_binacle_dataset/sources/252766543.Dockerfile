FROM alpine:latest  
  
RUN apk update && \  
apk add openssh && \  
rm -rf /var/cache/apk/* && \  
mkdir -p /root/.ssh && \  
chmod 700 /root/.ssh/  
  
ADD banner /  
ADD *.sh /  
ADD sshd_config /etc/ssh/sshd_config  
EXPOSE 22  
CMD /init.sh  

