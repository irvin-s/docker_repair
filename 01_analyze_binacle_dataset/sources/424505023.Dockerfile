FROM cikl/base:0.0.2
MAINTAINER Mike Ryan <falter@gmail.com>

RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6 && \
  echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y ruby2.1 libcurl3 libxml2 libxslt1.1 && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure that theonly thing that triggers a rebuild is modifications to the 
# Gemfile, and not anything else inside the src dir.
ADD src/Gemfile* src/VERSION /opt/cikl/scheduler/
ADD src/cikl-scheduler/cikl-scheduler.gemspec /opt/cikl/scheduler/cikl-scheduler/cikl-scheduler.gemspec
ADD src/cikl-event/cikl-event.gemspec /opt/cikl/scheduler/cikl-event/cikl-event.gemspec
ADD src/threatinator-output-cikl/threatinator-output-cikl.gemspec /opt/cikl/scheduler/threatinator-output-cikl/threatinator-output-cikl.gemspec

WORKDIR /opt/cikl/scheduler

ENV BUNDLE_GEMFILE /opt/cikl/scheduler/Gemfile.scheduler

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  buildDeps="gcc g++ make libc6-dev ruby2.1-dev zlib1g-dev libssl-dev patch libxml2-dev libxslt1-dev" && \
  apt-get update && \
  apt-get install -y --no-install-recommends $buildDeps && \
  gem install bundler && \
  bundle config build.nokogiri --use-system-libraries --with-xml2-include=/usr/include/libxml2/ && \
  bundle install --jobs=7 && \
  rm /var/lib/gems/2.1.0/cache/*.gem && \
  apt-get remove -y --purge --auto-remove $buildDeps && \
  apt-get autoremove -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD docker/scheduler/scheduler-web-command.sh /etc/docker-entrypoint/commands.d/scheduler-web
ADD docker/scheduler/scheduler-worker-command.sh /etc/docker-entrypoint/commands.d/scheduler-worker
ADD docker/scheduler/scheduler-command.sh /etc/docker-entrypoint/commands.d/scheduler
ADD docker/scheduler/threatinator-run-command.sh /etc/docker-entrypoint/commands.d/threatinator-run
ADD docker/scheduler/threatinator-run-all-command.sh /etc/docker-entrypoint/commands.d/threatinator-run-all
ADD docker/scheduler/threatinator-list-command.sh /etc/docker-entrypoint/commands.d/threatinator-list
ADD docker/scheduler/scheduler-pre.sh /etc/docker-entrypoint/pre.d/scheduler.sh

RUN chmod a+x /etc/docker-entrypoint/commands.d/scheduler-web \
              /etc/docker-entrypoint/commands.d/scheduler-worker \
              /etc/docker-entrypoint/commands.d/scheduler \
              /etc/docker-entrypoint/commands.d/threatinator-run \
              /etc/docker-entrypoint/commands.d/threatinator-run-all \
              /etc/docker-entrypoint/commands.d/threatinator-list

VOLUME [ "/data" ]
RUN useradd -s /bin/false -d /data -m cikl
ENV ENTRYPOINT_DROP_PRIVS 1
ENV ENTRYPOINT_USER cikl

ENV CIKL_RABBITMQ_URL amqp://cikl:cikl@rabbitmq/%2Fcikl
ENV SCHEDULER_REDIS_URL redis://redis/0

CMD [ "scheduler" ]

ADD src/cikl-scheduler /opt/cikl/scheduler/cikl-scheduler
ADD src/cikl-event /opt/cikl/scheduler/cikl-event
ADD src/threatinator-output-cikl /opt/cikl/scheduler/threatinator-output-cikl

EXPOSE 9292
