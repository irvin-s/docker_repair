FROM registry:2.2.1

ADD config.yml /etc/docker/registry
ADD gcs.json /etc/docker/registry
