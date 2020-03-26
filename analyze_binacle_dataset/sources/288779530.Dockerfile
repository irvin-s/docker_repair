FROM alpine:3.7
ENV MAVEN_REPO https://maven.cloudant.com/repo/

COPY ./maven-mirror/mirror-it /usr/bin

RUN apk add --no-cache wget=1.19.5-r0 \
  && chmod +x /usr/bin/mirror-it \
  && mkdir -p /maven_repo

VOLUME ["/maven_repo"]

CMD ["/usr/bin/mirror-it"]
