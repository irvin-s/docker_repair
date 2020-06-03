FROM debian  
MAINTAINER Dcylabs <dcylabs@gmail.com>  
RUN apt-get update  
RUN apt-get install -y ssh openssl python  
COPY sshd_config /etc/ssh/sshd_config  
COPY sftp_init /sftp_init  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /sftp_init  
RUN chmod +x /entrypoint.sh  
RUN addgroup --system filetransfer  
RUN mkdir /var/run/sshd  
CMD ["/entrypoint.sh"]

