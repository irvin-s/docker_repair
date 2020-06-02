FROM egovio/apline-jre:8u121

EXPOSE 8080

COPY /target/data-sync-employee-0.0.1-SNAPSHOT.jar /opt/egov/data-sync-employee.jar

COPY start.sh /usr/bin/start.sh

RUN chmod +x /usr/bin/start.sh

CMD ["/usr/bin/start.sh"]
