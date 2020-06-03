FROM dwolla/security-monkey-base:0.9.2  
MAINTAINER dev@dwolla.com  
  
ADD api-init.sh /usr/local/src/security_monkey/scripts/api-init.sh  
RUN chmod +x /usr/local/src/security_monkey/scripts/api-init.sh  
  
ENTRYPOINT ["/usr/local/src/security_monkey/scripts/api-init.sh"]  

