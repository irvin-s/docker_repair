FROM debian:stable  
MAINTAINER Alexey Bogdanenko <abogdanenko@dentavita.ru>  
  
# Install packages  
RUN apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install dovecot-imapd  
RUN useradd vmail  
ADD dovecot.conf /etc/dovecot/  
  
ADD run.sh /  
RUN chmod 755 /run.sh  
  
EXPOSE 143  
VOLUME ["/home/vmail"]  
  
# run dovecot in foreground  
CMD ["/run.sh"]  

