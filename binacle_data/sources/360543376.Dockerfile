FROM ubuntu:14.04

RUN apt-get update && apt-get install curl -y

RUN curl https://cloudstatsstorage.blob.core.windows.net/agent007/installer | sh -s cmBS5j5hvkrc-0mv2uLVtol8kdhAzw4uAVSy9QrbSRUBCKtRyK5-jzfisrDUfntmQpgkNupCQPu5GIG23be1FXw
RUN echo 'repo: agent007' >> /home/cloudstats_agent/config.yml
RUN echo 'statsd_protocol: udp' >> /home/cloudstats_agent/config.yml
RUN echo 'statsd_port: 8125' >> /home/cloudstats_agent/config.yml
RUN echo 'statsd_host: data1.cloudstats.me' >> /home/cloudstats_agent/config.yml

RUN echo 'statsd-udp-port' > /etc/cloudstats/server.key

RUN /home/cloudstats_agent/cloudstats-agent --first-time

CMD '/home/cloudstats_agent/cloudstats-agent'
