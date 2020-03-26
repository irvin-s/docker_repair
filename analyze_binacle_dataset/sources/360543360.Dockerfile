FROM ubuntu:latest

RUN apt-get update && apt-get install curl -y

RUN mkdir /home/cloudstats_agent
WORKDIR /home/cloudstats_agent
RUN curl -L -O --fail 'https://cloudstatsstorage.blob.core.windows.net/agent/cloudstats-agent-1.7.0-linux-x86_64.tar.gz'

RUN tar zxvf cloudstats-agent-1.7.0-linux-x86_64.tar.gz --strip-components 1 >/dev/null

COPY config.yml /home/cloudstats_agent/config.yml
RUN echo 'repo: agent007' >> /home/cloudstats_agent/config.yml
RUN /home/cloudstats_agent/cloudstats-agent --first-time

CMD '/home/cloudstats_agent/cloudstats-agent'
