FROM ubuntu:precise  
MAINTAINER Arquivei  
  
RUN apt-get update && apt-get -y install \  
apache2 php5 php5-mysql php5-dev mysql-server curl graphviz \  
supervisor build-essential python-pip netcat  
  
COPY xhprof /opt/xhprof  
COPY php.ini /etc/php5/cli/php.ini  
COPY php.ini /etc/php5/apache2/php.ini  
  
# add some confs  
COPY xhprof_vhost.conf.tpl /etc/apache2/sites-enabled/000-default.conf.tpl  
COPY config.php.tpl /opt/xhprof/xhprof_lib/  
RUN rm /etc/apache2/sites-enabled/000-default  
  
COPY my.cnf /etc/mysql/  
COPY schema.sql /tmp/  
  
COPY supervisord.conf /etc/supervisor/supervisord.conf  
  
RUN pip install envtpl==0.2.1  
  
COPY start.sh /bin/  
RUN chmod +x /bin/start.sh  
  
VOLUME /var/lib/mysql  
EXPOSE 3306 80  
CMD /bin/start.sh  

