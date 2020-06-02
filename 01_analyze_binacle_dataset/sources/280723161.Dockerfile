from clouthinkin/jre

ENV APP_VERSION "0.1.0-SNAPSHOT"

ADD build/libs/discovery-${APP_VERSION}.jar /
ADD docker/container_files/ /

RUN chmod +x /*.sh

EXPOSE 8761
WORKDIR /
ENTRYPOINT /docker-entrypoint.sh
