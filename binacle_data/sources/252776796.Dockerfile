FROM ccakes/perl-alpine:latest  
MAINTAINER cam.daniel@gmail.com  
  
ENV PINTO_REPOSITORY_ROOT /pinto  
ENV PINTO_USERNAME pinto  
ENV SERVER_PORT 3111  
RUN cpanm -i Pinto  
  
ADD files/run.sh /run.sh  
RUN chmod +x /run.sh  
  
CMD /run.sh  

