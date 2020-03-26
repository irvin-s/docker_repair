# Using centos 7 image
FROM java:8u72-jre
MAINTAINER ambud_sharma@symantec.com

RUN mkdir -p /usr/hendrix

RUN wget -O /usr/hendrix/re.jar 'path to repo'

CMD java -jar /usr/hendrix/re.jar /opt/config.properties