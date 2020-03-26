FROM alpine:latest  
MAINTAINER Uri Savelchev <alterrebe@gmail.com>  
  
# Add files  
ADD conf /root/conf  
  
# Configure: supervisor  
ADD bin/dfg.sh /usr/local/bin/  
ADD conf/supervisor-all.ini /etc/supervisor.d/  
# Runner  
ADD run.sh /root/run.sh  
  
# Packages: update  
RUN apk -U add postfix ca-certificates libsasl py-pip supervisor rsyslog && \  
pip install j2cli && \  
mkfifo /var/spool/postfix/public/pickup && \  
ln -s /etc/postfix/aliases /etc/aliases && \  
chmod +x /root/run.sh && \  
rm -rf /apk /tmp/* /var/cache/apk/*  
  
# Declare  
EXPOSE 25  
CMD ["/root/run.sh"]  

