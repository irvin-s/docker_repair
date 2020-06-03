FROM albinodrought/docker-alpine-mysql  
  
copy ./bootstrap.sh /scripts/bootstrap.sh  
RUN chmod +x /scripts/bootstrap.sh  
  
EXPOSE 3306  
ENTRYPOINT ["/scripts/bootstrap.sh"]  

