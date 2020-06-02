FROM openjdk:12-alpine

RUN apk add --no-cache bash curl nodejs tar fontconfig freetype && \
    addgroup -g 750 -S kibana && \
    adduser -u 750 -D -S -G kibana kibana

ENV HOME_DIR /usr/share/kibana
ENV KIBANA_VERSION 6.5.3

WORKDIR ${HOME_DIR}

RUN curl -Ls https://artifacts.elastic.co/downloads/kibana/kibana-oss-${KIBANA_VERSION}-linux-x86_64.tar.gz | tar zx --strip-components=1 && \
    rm -rf node/bin/node node/bin/npm && \
    ln -s /usr/bin/node ${HOME_DIR}/node/bin/node && \
    ln -s /usr/bin/npm ${HOME_DIR}/node/bin/npm

COPY assets/kibana.yml /opt/kibana/config/kibana.yml

RUN chown -R kibana:kibana ${HOME_DIR} ${HOME_DIR}/*

USER kibana

EXPOSE 5601

#RUN ${HOME_DIR}/bin/kibana-plugin install x-pack

ENTRYPOINT ["/usr/share/kibana/bin/kibana"]

CMD []
