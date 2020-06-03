#
# This is the docker image used for ./bin/run-tests.sh and development tasks.
#
# It will NOT reresolve all dependencies on every change (as opposed to Dockerfile)
# but it ultimately results in a larger docker image.
#
FROM java:8-jdk

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF && \
    echo "deb http://repos.mesosphere.com/debian jessie-testing main" | tee /etc/apt/sources.list.d/mesosphere.list && \
    echo "deb http://repos.mesosphere.com/debian jessie main" | tee -a /etc/apt/sources.list.d/mesosphere.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y --force-yes mesos=1.0.0-1.0.73.rc2.debian81

# Install docker
ARG DOCKER_VERSION=latest
RUN curl -o /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} && chmod +x /usr/bin/docker

# Clone marathon
RUN git clone https://github.com/mesosphere/marathon.git

WORKDIR /marathon

# Install sbt 
RUN eval $(sed s/sbt.version/SBT_VERSION/ </marathon/project/build.properties) && \
    mkdir -p /usr/local/bin && \
    wget -P /usr/local/bin/ https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar
RUN cp project/sbt /usr/local/bin/
RUN chmod +x /usr/local/bin/sbt
