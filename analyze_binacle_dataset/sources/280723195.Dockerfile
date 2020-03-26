from clouthinkin/jre

ENV APP_VERSION "0.1.0-SNAPSHOT"

ADD build/libs/sample-${APP_VERSION}.jar /
ADD docker/container_files/ /

RUN chmod +x /*.sh

EXPOSE 8080
WORKDIR /
ENTRYPOINT /docker-entrypoint.sh
