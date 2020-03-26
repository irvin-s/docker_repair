From ubuntu:14.04  
MAINTAINER Alex Drummer <drummerroma@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# log mail configuration  
ENV DB_HOST localhost  
ENV MAILSERVER smtp.gmail.com:587  
ENV MAILTO yourname@gmail.com  
ENV MAILFROM automysqlbackup  
ENV SMTP_USER yourname@gmail.com  
ENV SMTP_PASS yourpass  
ENV USETLS YES  
ENV USESTARTTLS YES  
  
RUN apt-get update && apt-get -y dist-upgrade && \  
apt-get -y install automysqlbackup && \  
apt-get -y install ssmtp && \  
apt-get -y clean  
  
ADD run.sh /run.sh  
ADD automysqlbackup.default /etc/default/automysqlbackup  
CMD ["/run.sh"]

