FROM java:8

ENV TZ Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD ./start.sh /start.sh
ADD ./mc-mms-server-standalone-*.jar /archive/mc-mms/distribution/mc-mms-server-standalone/target/
EXPOSE 43234 43235
CMD ["/bin/bash", "/start.sh"]

