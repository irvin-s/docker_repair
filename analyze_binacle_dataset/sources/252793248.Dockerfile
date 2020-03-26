FROM tutum/lamp:latest  
MAINTAINER Daniel Isserow  
  
RUN rm -fr /app && git clone https://github.com/dannyiss/DockerCAB432.git /app  
EXPOSE 80 3306  
CMD ["/run.sh"]

