FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
cntlm \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD run.sh /run.sh  
  
RUN chmod +x /run.sh  
  
ENV CNTLM_NO_PROXY "localhost, 127.0.0.*, 10.*, 192.168.*, *.local"  
EXPOSE 3128  
ENTRYPOINT ["/run.sh"]  
  
CMD [""]  

