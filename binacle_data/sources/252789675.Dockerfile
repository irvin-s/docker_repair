FROM webratio/groovy:2.4.4  
ADD scripts/* /opt/resource/  
ADD *.groovy /  
ADD truststore.jks /  

