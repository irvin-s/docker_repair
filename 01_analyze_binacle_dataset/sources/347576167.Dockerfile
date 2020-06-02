#
# Dockerfile for Takuhai Tracker worker process
#
# need some ENVs:
#   MONGODB_URI
#
FROM ruby:2.6
LABEL maintainer "@tdtds <t@tdtds.jp>"

RUN apt update && apt install -y busybox-static; \
    mkdir -p /app/takuhai-tracker; \
	 mkdir -p /var/spool/cron/crontabs
COPY ["misc/docker/worker/crontab", "/var/spool/cron/crontabs/root"]
COPY ["Gemfile", "Gemfile.lock", "/app/takuhai-tracker/"]

WORKDIR /app/takuhai-tracker
RUN bundle --path=vendor/bundle --without=development:test --jobs=4 --retry=3
COPY [".", "/app/takuhai-tracker/"]

ENV RACK_ENV=production
ENV TZ=Asia/Tokyo
CMD ["busybox", "crond", "-L", "/dev/stderr", "-f"]
