FROM bconnect/gitlab-base:1.2  
COPY playbook /playbook  
COPY runner.sh /runner.sh  
  
RUN chmod +x /runner.sh  
  
CMD ["/runner.sh"]  

