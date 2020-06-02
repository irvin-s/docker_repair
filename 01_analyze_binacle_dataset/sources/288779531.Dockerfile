FROM ruby:2.3.7-alpine

COPY ./maven-mirror/push-it /usr/bin

RUN apk add --no-cache build-base=0.5-r0 \
  && gem install --no-ri --no-rdoc package_cloud -v 0.3.05 \
  && mkdir /maven_repo \
  && chmod +x /usr/bin/push-it

VOLUME ["/maven_repo"]

CMD ["push-it"]
