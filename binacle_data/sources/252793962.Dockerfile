FROM debian:jessie  
MAINTAINER Tim Peters <mail@darksecond.nl>  
  
RUN groupadd -r vmail && useradd -r -g vmail vmail  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y dovecot-core dovecot-imapd dovecot-lmtpd dovecot-sieve  
  
RUN rm -rf /etc/dovecot  
ADD dovecot /etc/dovecot  
  
RUN sievec /etc/dovecot/sieve-before/  
RUN sievec /etc/dovecot/sieve-after/  
  
ADD entrypoint.sh /entrypoint.sh  
  
VOLUME ["/var/vmail"]  
VOLUME ["/etc/dovecot/passwd"]  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["dovecot", "-F"]  
  
# SASL  
EXPOSE 12345  
# IMAP  
EXPOSE 143  
# IMAPS  
EXPOSE 993  
# LMTP  
EXPOSE 24  

