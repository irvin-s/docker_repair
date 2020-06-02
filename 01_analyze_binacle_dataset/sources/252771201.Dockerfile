FROM php:7-apache  
  
RUN apt-get update && apt-get install -y aria2 wget zip  
RUN wget https://github.com/ilikenwf/apt-fast/archive/master.zip  
RUN unzip master.zip  
RUN cp apt-fast-master/apt-fast /usr/bin  
RUN cp apt-fast-master/apt-fast.conf /etc  
RUN cp apt-fast-master/man/apt-fast.8 /usr/share/man/man8  
RUN gzip /usr/share/man/man8/apt-fast.8  
RUN cp apt-fast-master/man/apt-fast.conf.5 /usr/share/man/man5  
RUN gzip /usr/share/man/man5/apt-fast.conf.5  
RUN rm -r apt-fast-master  
  
# Inherit from based image  
CMD ["apache2-foreground"]

