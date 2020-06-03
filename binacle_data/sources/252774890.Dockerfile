FROM centos:7  
MAINTAINER bazulay@gmail.com  
  
ENV TARGET_URL="http://django-example-proj-001.10.35.49.13.nip.io/"  
ENV NUM_OF_CONSECUTIVE_REQUESTS=10  
ENV SLEEP_TIME=5  
ADD loop.sh /  
RUN chmod 755 /loop.sh  
  
CMD ["/loop.sh"]  
  

