FROM java:8-jdk-alpine
ENV TZ="Asia/Shanghai"
ENV LANG C.UTF-8
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*
ADD build/libs/yugong.jar /root/yugong.jar
ADD bin /root/
RUN chmod +x /root/*.sh;mkdir /root/logs
RUN mkdir /root/pinpoint-agent-1.6.1-SNAPSHOT \
    && curl -o /root/pinpoint-agent-1.6.1-SNAPSHOT/pinpoint-agent-1.6.1-SNAPSHOT.zip --user 'liushiming:Hello899' http://repo.quancheng-ec.com/repository/documentation/pinpoint-agent-1.6.1-SNAPSHOT.zip \
	&& unzip -o -d /root/pinpoint-agent-1.6.1-SNAPSHOT /root/pinpoint-agent-1.6.1-SNAPSHOT/pinpoint-agent-1.6.1-SNAPSHOT.zip \
    && rm -r /root/pinpoint-agent-1.6.1-SNAPSHOT/pinpoint-agent-1.6.1-SNAPSHOT.zip
ENV JAVA_OPTS ""
WORKDIR /root
CMD ["./start.sh"]
