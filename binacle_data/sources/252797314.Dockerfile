FROM cloyne/wordpress  
  
MAINTAINER Mitar <mitar.docker@tnode.com>  
  
COPY ./plugins /wordpress/wp-content/plugins  
COPY ./themes /wordpress/wp-content/themes  

