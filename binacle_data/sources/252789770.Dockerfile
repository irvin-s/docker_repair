FROM dwolla/security-monkey-base:0.8.0  
MAINTAINER dev@dwolla.com  
RUN mkdir /var/log/security_monkey &&\  
chown www-data /var/log/security_monkey &&\  
mkdir /var/www &&\  
chown www-data /var/www &&\  
touch /var/log/security_monkey/securitymonkey.log &&\  
chown www-data /var/log/security_monkey/securitymonkey.log  
  
ADD api-start.sh /usr/local/src/security_monkey/scripts/api-start.sh  
  
RUN chmod +x /usr/local/src/security_monkey/scripts/api-start.sh  
  
EXPOSE 5000  
ENTRYPOINT ["/usr/local/src/security_monkey/scripts/api-start.sh"]  

