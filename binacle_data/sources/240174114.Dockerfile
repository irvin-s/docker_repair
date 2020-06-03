FROM egovio/apline-jre:8u121

MAINTAINER kaviyarasan<kaviyarasan.p@riflexions.com>

COPY /target/egov-demand-0.0.1-SNAPSHOT.jar /opt/egov/demand-services.jar

COPY start.sh /usr/bin/start.sh

RUN chmod +x /usr/bin/start.sh

CMD ["/usr/bin/start.sh"]
