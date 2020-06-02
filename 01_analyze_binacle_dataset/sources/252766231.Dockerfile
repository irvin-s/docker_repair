FROM abaranov/base  
MAINTAINER abaranov@linux.com  
  
ADD gerrit.yml /ansible/gerrit.yml  
ADD start.sh /start.sh  
RUN chmod 755 /start.sh  
RUN ansible-playbook /ansible/gerrit.yml  
RUN rm -rf /ansible  
EXPOSE 8080 29418  
CMD ["/etc/init.d/supervisord","start"]  

