FROM eeacms/varnish:4s  
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>  
  
ADD ./conf.d/main.vcl /etc/varnish/conf.d/  
ADD ./conf.d/backends.vcl /etc/varnish/conf.d/  
ADD 500msg.html /var/static/  

