FROM canelrom1/debian-canel:latest  
MAINTAINER Rom1 <rom1@canel.ch> \- CANEL - https://www.canel.ch  
  
LABEL date="25/09/17"  
LABEL version="1.0"  
LABEL description="Server SSL + FTP with vsFTPd"  
  
RUN apt-get update \  
&& apt-get -y -q --no-install-recommends \  
install vsftpd  
  
COPY ./conf/vsftpd.conf /etc/vsftpd.conf  
  
EXPOSE 21  
COPY ./entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["vsftpd"]  

