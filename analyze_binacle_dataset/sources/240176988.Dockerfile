FROM egovio/apline-jre:8u121

MAINTAINER Sumanth<nsready@gmail.com>

EXPOSE 8080

COPY /target/data-sync-task-0.0.1.jar /opt/egov/data-sync-task.jar

COPY start.sh /usr/bin/start.sh

RUN chmod +x /usr/bin/start.sh

CMD ["/usr/bin/start.sh"]
