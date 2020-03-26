FROM openjdk:10

# A merge of:
#  https://github.com/zhilvis/docker-h2
#  https://github.com/zilvinasu/h2-dockerfile

MAINTAINER Oscar Fonts <oscar.fonts@geomati.co>

ENV DOWNLOAD https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/h2database/h2-2009-09-26.zip
ENV DATA_DIR /opt/h2-data

RUN mkdir -p ${DATA_DIR} \
    && curl ${DOWNLOAD} -o h2.zip \
    && unzip h2.zip -d /opt/ \
    && rm h2.zip

COPY h2.server.properties /root/.h2.server.properties

EXPOSE 81 1521

WORKDIR /opt/h2-data

CMD java -cp /opt/h2/bin/h2*.jar org.h2.tools.Server \
 	-web -webAllowOthers -webPort 81 \
 	-tcp -tcpAllowOthers -tcpPort 1521 \
 	-baseDir ${DATA_DIR}
