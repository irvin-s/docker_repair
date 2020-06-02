FROM pavelzotikov/docker-web-server:lite-web-server  
MAINTAINER CodeX Team team@ifmo.su  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get install -y git  
  
RUN echo -e '\033[01;35m Git clone fired... \033[0m'  
RUN git clone https://github.com/codex-team/codex.git /var/www  
RUN echo -e '\033[00;32m CodeX repository cloned \033[0m'  
  
RUN cp /var/www/tools/_.htaccess /var/www/.htaccess  
RUN echo -e '\033[01;35m .htaccess moved \033[0m'  
  
RUN echo -e '\033[01;35m Making application/logs folder... \033[0m'  
RUN mkdir /var/www/application/logs && chmod 777 /var/www/application/logs  
  
RUN echo -e '\033[01;35m Making application/cache folder... \033[0m'  
RUN mkdir /var/www/application/cache && chmod 777 /var/www/application/cache  
  
VOLUME ["/var/www"]  
  
EXPOSE 80  

