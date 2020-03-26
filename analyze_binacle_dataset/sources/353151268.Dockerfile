#
# Triton-optimized Mesos agent
#
FROM 		misterbisson/triton-mesos:2015-07-06-triton
MAINTAINER 	Casey Bisson <casey.bisson@gmail.com>

# install wget
RUN apt-get update -q && \
    apt-get install -qy wget

# install Docker
RUN wget -qO- https://get.docker.com/ | sh

# add our start script
ADD sbin /usr/local/sbin

# Docker remote api connection vars
ENV DOCKER_CERT_PATH=/root/.sdc/docker/
ENV DOCKER_CLIENT_TIMEOUT=300
ENV DOCKER_TLS_VERIFY=1

# Docker API timeouts
# suggested per https://mesosphere.github.io/marathon/docs/native-docker.html
ENV EXECUTOR_REGISTRATION_TIMEOUT=${EXECUTOR_REGISTRATION_TIMEOUT:-7mins}
ENV EXECUTOR_SHUTDOWN_GRACE_PERIOD=${EXECUTOR_SHUTDOWN_GRACE_PERIOD:-3mins}

# Mesos resource limits
ENV MESOS_RESOURCES_CPUS=${MESOS_RESOURCES_CPUS:-100}
ENV MESOS_RESOURCES_MEM=${MESOS_RESOURCES_MEM:-245760}
ENV MESOS_RESOURCES_DISK=${MESOS_RESOURCES_DISK:-4096}
ENV MESOS_PORT=${MESOS_PORT:-5051}

#
# Mesos general configuration
# see http://mesos.apache.org/documentation/latest/configuration/
#
ENV MESOS_HOSTNAME_LOOKUP=false

EXPOSE $MESOS_PORT

CMD ["triton-mesos-agent"]

