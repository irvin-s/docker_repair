FROM alpine  
RUN apk add --update --no-cache openssh sshpass  
WORKDIR /tmp/share  
CMD sftp  

