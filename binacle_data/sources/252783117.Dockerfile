FROM httpd:2.4  
RUN apt-get update \  
&& apt-get -y install ca-certificates stunnel uwsgi curl  
  
COPY ["httpd.conf", "/usr/local/apache2/conf/httpd.conf"]  
COPY ["etc_default_stunnel4", "/etc/default/stunnel4"]  
COPY ["stunnel.conf", "/etc/stunnel/stunnel.conf"]  
COPY ["cmd.sh", "/cmd.sh"]  
  
CMD ["/cmd.sh"]  

