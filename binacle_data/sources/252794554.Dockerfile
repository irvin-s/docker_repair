FROM httpd:alpine  
MAINTAINER racoon  
RUN echo " <!DOCTYPE html> \  
<html> \  
<head> \  
<title>TESTPAGE</title> \  
</head> \  
<body> \  
\  
<h1>This is a Heading</h1> \  
<h3>This is a sub heading</h3> \  
<p>This is a paragraph.</p> \  
\  
</body> \  
</html>" > /usr/local/apache2/htdocs/index.html  
EXPOSE 80  
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]  

