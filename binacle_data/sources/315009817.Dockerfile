FROM blacklabelops/java:openjre.8

# Image Build Date By Buildsystem
ARG BUILD_DATE=undefined

ENV CRONUT_HOME=/opt/cronut/ \
    CROW_GLOBAL_ENVIRONMENT_PREFIX=CRONUT_ \
    crow.global.property.prefix=com.blacklabelops.cronut. \
    CROW_JOB_ENVIRONMENT_PREFIX=CRONJOB \
    crow.job.property.prefix=com.blacklabelops.cronjob. \
    CROW_DOCKER_CRAWLER_ENABLED=true \
    CRONUT_HOME=/opt/cronut \
    JAVA_OPTS=-Xmx64m \
    DOCKER_HOST=unix:///var/run/docker.sock

RUN apk add --update --no-cache --virtual .build-deps \
      curl && \
    mkdir -p ${CRONUT_HOME} && \
    curl -fsSL https://80-112953069-gh.circle-artifacts.com/0/root/crow/application/target/artifacts/crow-application-0.5-SNAPSHOT.jar -o ${CRONUT_HOME}/crow-application.jar && \
    # Cleanup
    apk del .build-deps && \
    rm -rf /var/cache/apk/* && rm -rf /tmp/* && rm -rf /var/log/*

COPY imagescripts ${CRONUT_HOME}

RUN cp ${CRONUT_HOME}/cronut.sh /usr/bin/cronut && \
    chmod +x /usr/bin/cronut

# Image Metadata
LABEL com.blacklabelops.image.builddate.cronut=${BUILD_DATE}

EXPOSE 8080
WORKDIR ${CRONUT_HOME}
ENTRYPOINT ["/sbin/tini","--","/opt/cronut/docker-entrypoint.sh"]
CMD ["cronut-daemon"]
