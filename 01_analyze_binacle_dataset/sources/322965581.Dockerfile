
FROM cirepo/service-base-image-java:openjdk-11.0.2-en_US.UTF-8_Etc.UTC-alpine-SNAPSHOT


ARG JAR_FILE


COPY --chown=alpine:alpine src/main/docker /
COPY --chown=alpine:alpine target/${JAR_FILE} /home/alpine
RUN set -ex \
  && chmod 0755 /home/alpine/*.sh
