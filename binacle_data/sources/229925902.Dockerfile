FROM 		tomcat:8.0.21-jre8

MAINTAINER 	Amjad Afanah (amjad@dchq.io)

COPY 		./software/ /usr/local/tomcat/webapps/
