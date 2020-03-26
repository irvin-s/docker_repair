FROM jfrogtraining-docker-dev.jfrog.io/docker-hello:97

MAINTAINER Stanley Fong  stanleyf@jfrog.com

ADD war/*.war .

CMD /bin/bash -c cd /home/exec; /home/exec/tomcat/bin/catalina.sh run
