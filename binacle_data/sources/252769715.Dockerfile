FROM ubuntu:12.04  
MAINTAINER Aaron Krieshok <akrieshok@gmail.com>  
  
ADD ./lamp.sh /lamp.sh  
RUN chmod 755 /lamp.sh  
RUN /lamp.sh  
RUN rm -f /lamp.sh  
  
RUN easy_install supervisor  
ADD ./start.sh /start.sh  
ADD ./foreground.sh /etc/apache2/foreground.sh  
ADD ./supervisord.conf /etc/supervisord.conf  
RUN chmod 755 /start.sh && chmod 755 /etc/apache2/foreground.sh  
  
CMD ["/bin/bash", "/start.sh"]  

