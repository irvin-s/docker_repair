FROM nginx:1.9.15  
RUN apt-get -qqy update && apt-get -qqy install cron curl supervisor  
  
ADD bin/ /usr/bin/  
ADD supervisord.conf /etc/supervisor/conf.d/  
  
ENTRYPOINT ["/bin/bash", "-e"]  
CMD inject-and-run override_this localhost:8080  

