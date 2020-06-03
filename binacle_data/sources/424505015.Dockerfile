FROM cikl/base:0.0.2
MAINTAINER Mike Ryan <falter@gmail.com>

RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6 && \
  echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y ruby2.1 libunbound2 libcurl3 && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure that theonly thing that triggers a rebuild is modifications to the 
# Gemfile, and not anything else inside the src dir.
ADD src/Gemfile* src/VERSION /opt/cikl/core/
ADD src/cikl-core/cikl-core.gemspec /opt/cikl/core/cikl-core/cikl-core.gemspec
ADD src/cikl-api/cikl-api.gemspec /opt/cikl/core/cikl-api/cikl-api.gemspec
ADD src/cikl-worker/cikl-worker.gemspec /opt/cikl/core/cikl-worker/cikl-worker.gemspec
ADD src/cikl-event/cikl-event.gemspec /opt/cikl/core/cikl-event/cikl-event.gemspec

WORKDIR /opt/cikl/core

ENV BUNDLE_GEMFILE /opt/cikl/core/Gemfile.core

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  buildDeps="gcc g++ make libc6-dev ruby2.1-dev zlib1g-dev libssl-dev patch" && \
  apt-get update && \
  apt-get install -y --no-install-recommends $buildDeps && \
  gem install bundler && \
  bundle install --jobs=7 && \
  rm /var/lib/gems/2.1.0/cache/*.gem && \
  apt-get remove -y --purge --auto-remove $buildDeps && \
  apt-get autoremove -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD docker/core/dns-worker-command.sh /etc/docker-entrypoint/commands.d/dns-worker
ADD docker/core/api-command.sh /etc/docker-entrypoint/commands.d/api
ADD docker/core/test-unit-command.sh /etc/docker-entrypoint/commands.d/test-unit
ADD docker/core/test-all-command.sh /etc/docker-entrypoint/commands.d/test-all
ADD docker/core/core-pre.sh /etc/docker-entrypoint/pre.d/core.sh

RUN chmod a+x /etc/docker-entrypoint/commands.d/dns-worker \
              /etc/docker-entrypoint/commands.d/api \
              /etc/docker-entrypoint/commands.d/test-unit \
              /etc/docker-entrypoint/commands.d/test-all

VOLUME [ "/data" ]
RUN useradd -s /bin/false -d /data -m cikl
ENV ENTRYPOINT_DROP_PRIVS 1
ENV ENTRYPOINT_USER cikl

ENV CIKL_MONGO_URI mongodb://mongodb/cikl
ENV CIKL_ELASTICSEARCH_URI http://elasticsearch:9200/
ENV CIKL_ELASTICSEARCH_INDEX cikl
ENV CIKL_RABBITMQ_URL amqp://cikl:cikl@rabbitmq/%2Fcikl

CMD [ "help" ]

# Expose cikl-api service
EXPOSE 9292

ADD src/cikl-core /opt/cikl/core/cikl-core
ADD src/cikl-api /opt/cikl/core/cikl-api
ADD src/cikl-worker /opt/cikl/core/cikl-worker
ADD src/cikl-event /opt/cikl/core/cikl-event

