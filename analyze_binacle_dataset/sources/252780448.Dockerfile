FROM alpine:latest  
MAINTAINER Bryan <bryan@macdata.io>  
  
# Packages: update  
RUN apk -U add \  
postfix \  
ca-certificates \  
libsasl \  
py-pip \  
supervisor \  
rsyslog\  
&& rm -rf /var/cache/apk/*  
  
RUN pip install j2cli  
  
# Add files  
ADD conf /root/conf  
RUN mkfifo /var/spool/postfix/public/pickup \  
&& ln -s /etc/postfix/aliases /etc/aliases  
  
# Configure: supervisor  
ADD bin/dfg.sh /usr/local/bin/  
ADD conf/supervisor-all.ini /etc/supervisor.d/  
  
# Manage secrets.  
ADD secrets.sh /root/secrets.sh  
RUN chmod +x /root/secrets.sh  
  
# Runner  
ADD run.sh /root/run.sh  
RUN chmod +x /root/run.sh  
  
# Declare  
EXPOSE 25  
CMD ["/root/run.sh"]  

