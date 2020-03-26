FROM egovio/apline-jre:8u121

COPY /target/pgr-notification-0.0.1-SNAPSHOT.jar /opt/egov/pgr-notification.jar
COPY start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

CMD ["/usr/bin/start.sh"]
