FROM rounds/10m-base
MAINTAINER Ofir Petrushka ROUNDS <ofir@rounds.com>

# Generic (should be in base images if this issue https://github.com/docker/docker/issues/3639 is ever resolved)
VOLUME ["/var/log"]

# Here we are copying and installing the resulting package from the build docker.
# To create the package (the makefile does it already):
# cd builder && docker-compose run logstashforwarderbuilder
COPY builder/logstash-forwarder_*_amd64.deb .

RUN dpkg -i logstash-forwarder_*_amd64.deb && \
    rm logstash-forwarder_*_amd64.deb

# We run logstash forwarder with restarts every hour due to issues of not releasing delete log files. (might cause your disk to run out of space)
CMD timeout 1h /etc/logstash-forwarder/run.sh
