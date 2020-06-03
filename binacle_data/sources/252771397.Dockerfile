FROM centos:centos7  
MAINTAINER Andrew Matheny <andrew.j.matheny@gmail.com>  
  
  
RUN curl -L https://bootstrap.saltstack.com -o install_salt.sh  
RUN sh install_salt.sh -X git v2015.2.0rc1  
  
ADD run.sh /usr/local/bin/run.sh  
RUN chmod +x /usr/local/bin/run.sh  
  
CMD ["/usr/local/bin/run.sh"]  

