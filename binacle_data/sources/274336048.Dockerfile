FROM openjdk:8-jre-alpine
MAINTAINER Ben.Ma <cma@maxleap.com>

#----------------------------Copy 项目目录到容器里--------------------------------------------


ENV BIFROST_HOME "/opt/bifrost"


WORKDIR $BIFROST_HOME

ENTRYPOINT [\
"java",\
"-XX:+UseG1GC",\
"-Djava.net.preferIPv4Stack=true",\
"-Dlog4j.configurationFile=file:log4j2.xml",\
"-jar",\
"bifrost-server-jar-with-dependencies.jar"\
]

ADD ./ ./
