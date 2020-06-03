FROM sameersbn/gitlab:7.3.0  
MAINTAINER Centurylink  
  
ADD dbsetup.sh /app/setup/  
RUN chmod +x /app/setup/dbsetup.sh  
  
CMD ["/app/setup/dbsetup.sh"]  
  

