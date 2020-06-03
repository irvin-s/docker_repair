FROM us-demo-4x.jfrog.info:9002/docker-framework:latest

MAINTAINER Mark Galpin markg@jfrog.com

ADD war/*.war /home/exec/tomcat/webapps/swampup.war

CMD /bin/bash -c cd /home/exec; /home/exec/tomcat/bin/catalina.sh run
