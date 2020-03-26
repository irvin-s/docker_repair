FROM anapsix/alpine-java:8_jdk_unlimited  
  
LABEL maintainer "Brian Tkatch, brian@briantkatch.com"  
  
ADD https://www.crushftp.com/early8/CrushFTP8_PC.zip /tmp/CrushFTP8_PC.zip  
ADD ./setup.sh /var/opt/setup.sh  
ADD ./crushftp_init_nobackground.sh /var/opt/run_crushftp.sh  
RUN chmod +x /var/opt/setup.sh  
RUN chmod +x /var/opt/run_crushftp.sh  
  
ENTRYPOINT /var/opt/setup.sh  
  
# FTP Server  
EXPOSE 21  
# HTTPS Server  
EXPOSE 443  
# FTP PASV transfers  
EXPOSE 2000-2010  
# SSH Server  
EXPOSE 2222  
# HTTP Servers  
EXPOSE 8080 9090

