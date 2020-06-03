FROM golang:1.8  
COPY bin /bin  
RUN chmod +x /bin/start.sh && \  
chmod +x /bin/aws-es-proxy-0.3-linux-amd64  
CMD "/bin/start.sh"  

