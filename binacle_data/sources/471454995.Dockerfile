FROM docker:stable-dind

WORKDIR /docker

RUN apk add --no-cache bash curl openssl

COPY . .

RUN chmod +x /docker/build.sh
RUN chmod +x /docker/trigger.sh

CMD ["/docker/build.sh"]
