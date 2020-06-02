## -*- docker-image-name: "nordstrom/xrpc" -*-
FROM debian:stretch
MAINTAINER Jeff Rose <jeff.rose@nordstrom.com>

# ===== Use the "noninteractive" debconf frontend =====
ENV DEBIAN_FRONTEND noninteractive

ENV PORT=8080

# ===== Update apt-get =====
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get upgrade -y

# ===== Install sudo  =====
RUN apt-get -y install sudo locales ca-certificates

# ==== Set locales and Timezones and whatnot =====
RUN sudo echo "America/Los_Angeles" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN sudo echo 'LANG="en_US.UTF-8"'>/etc/default/locale
RUN sudo dpkg-reconfigure --frontend=noninteractive locales
RUN sudo update-locale LANG=en_US.UTF-8

# ===== Installing packages =====
RUN apt-get install -y \
git-core \
wget \
unzip \
curl \
libssl-dev \
openjdk-8-jdk \
--no-install-recommends

# ===== Build xrpc  =====
COPY . /opt/xrpc
WORKDIR /opt/xrpc

# ===== Clean Up Apt-get =====
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

WORKDIR /app
COPY . .

RUN ./gradlew clean shadowJar && \
  mv demos/people/build/libs/xrpc-people-demo-0.1.1-SNAPSHOT-all.jar app.jar

CMD java  \
  -Dconfig.file=application.conf \
  -Djava.net.preferIPv4Stack=true \
  -Dio.netty.allocator.type=pooled \
  -XX:+UseStringDeduplication     \
  -XX:+UseTLAB                    \
  -XX:+AggressiveOpts             \
  -XX:+UseConcMarkSweepGC         \
  -XX:+CMSParallelRemarkEnabled   \
  -XX:+CMSClassUnloadingEnabled   \
  -XX:ReservedCodeCacheSize=128m  \
  -XX:SurvivorRatio=128           \
  -XX:MaxTenuringThreshold=0      \
  -XX:MaxDirectMemorySize=8G      \
  -Xss8M                          \
  -Xms512M                        \
  -Xmx4G                          \
  -server                         \
  -Dcom.sun.management.jmxremote                    \
  -Dcom.sun.management.jmxremote.port=9010          \
  -Dcom.sun.management.jmxremote.local.only=false   \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false          \
  -Dserver.port=$PORT                               \
  -Dconfig.file=application.conf                    \
  -jar app.jar
