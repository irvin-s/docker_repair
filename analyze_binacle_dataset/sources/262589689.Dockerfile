FROM alpine:latest
MAINTAINER nicodeur <nico.deblock@gmail.com>

RUN apk --no-cache add --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ git nodejs nodejs-npm tar wget ca-certificates && \
	npm install npm@latest -g && rm -rf /var/cache/apk/*

RUN wget https://github.com/nicodeur/QualityDashboard/archive/1.1.0.tar.gz && mkdir /opt && mkdir /opt/qualityReport && mkdir /opt/qualityReportTmp && \
	tar xzvf 1.1.0.tar.gz -C /opt/qualityReportTmp && mv  /opt/qualityReportTmp/QualityDashboard*/* /opt/qualityReport && rm -Rf /opt/qualityReportTmp

WORKDIR /opt/qualityReport/
RUN ls -al

RUN chmod 755 installDependencies.sh && dos2unix installDependencies.sh && ./installDependencies.sh

WORKDIR /opt/qualityReport

CMD chmod 755 start.sh && chmod 755 front/start.sh  && chmod 755 server/start.sh && chmod 755 stop.sh && chmod 755 restart.sh &&\
    dos2unix  start.sh && dos2unix  front/start.sh  && dos2unix  server/start.sh && dos2unix  stop.sh && dos2unix  restart.sh &&\
  ./start.sh && tail -f logs/server.log

EXPOSE 8085 8086
