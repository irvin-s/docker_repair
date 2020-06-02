FROM httpd:2.4  
MAINTAINER Tom Neumann <tom.neumann@stud.htwk-leipzig.de>  
  
COPY ./snorql /usr/local/apache2/htdocs/  

