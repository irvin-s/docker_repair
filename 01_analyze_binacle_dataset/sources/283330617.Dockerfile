FROM gcr.io/google_containers/fluentd-elasticsearch:1.22

RUN apt-get update && \
    apt-get install -y --no-install-recommends make gcc g++ libc6-dev ruby-dev && \
    td-agent-gem install fluent-plugin-concat --version '~>1.0.0' --no-ri --no-rdoc && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false make gcc g++ libc6-dev ruby-dev

# Copy the Fluentd configuration file for concatenating lines in docker logs.
COPY td-agent.conf /etc/td-agent/td-agent.conf
