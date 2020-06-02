FROM alpine:3.4  
MAINTAINER Rafael de Paula Herrera <herrera.rp@gmail.com>  
  
RUN apk add --no-cache tftp-hpa && \  
mkdir -p /tftpboot  
  
VOLUME /tftpboot  
  
EXPOSE 69/udp  
  
ENTRYPOINT ["/usr/sbin/in.tftpd"]  
CMD ["--foreground", "--secure", "--verbose", "/tftpboot"]  

