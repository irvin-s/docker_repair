FROM jenkinsci/jnlp-slave

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.0.tgz
ENV DOCKER_SHA256 87331b3b75d32d3de5d507db9a19a24dd30ff9b2eb6a5a9bdfaba954da15e16b
ENV DOCKER_HOME /tmp/docker_tar
ENV DOCKER_HOST unix:///var/run/docker.sock
# GID currently in use by AWS EC2 Container Service
ENV DOCKER_GID 497

USER root

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o ${DOCKER_HOME} \
    && echo "${DOCKER_SHA256} ${DOCKER_HOME}" | sha256sum -c - \
    && chmod +x ${DOCKER_HOME}

RUN tar -xvf /tmp/docker_tar -C /tmp
RUN cp /tmp/docker/docker /usr/bin/docker
RUN groupadd -g ${DOCKER_GID} docker
RUN usermod -G docker jenkins
RUN \
  # install utilities
  apt-get update && apt-get install -y \
     wget \
     curl \
     vim \
     git \
     zip \
     bzip2 \
     fontconfig \
     python \
     python-pip

RUN pip install ecs-deploy awscli
RUN mkdir /root/.ssh
RUN mkdir /home/jenkins/.ssh

COPY slave-entrypoint.sh /usr/local/bin/slave-entrypoint.sh
RUN chmod +x /usr/local/bin/slave-entrypoint.sh

USER jenkins
ENTRYPOINT ["slave-entrypoint.sh"]
