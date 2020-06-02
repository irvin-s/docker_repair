FROM openjdk:8u131-jre-alpine

RUN apk add --no-cache bash curl libc6-compat tar && \
    addgroup -g 750 -S logstash && \
    adduser -u 750 -D -S -G logstash logstash 

ENV HOME_DIR /usr/share/logstash
ENV VERSION 6.5.3

WORKDIR ${HOME_DIR}

RUN curl -fsSL https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.tar.gz | tar zx --strip-components=1

RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-csv \
                                                    logstash-input-cloudwatch_logs \
                                                    logstash-input-s3

#COPY ./assets/logstash.yml /usr/share/logstash/config/logstash.yml

RUN chown -R logstash:logstash ${HOME_DIR} ${HOME_DIR}/*

USER logstash

EXPOSE 5000 35753

ENTRYPOINT ["/usr/share/logstash/bin/logstash"]

CMD []
