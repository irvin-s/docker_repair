FROM java7jre_image

RUN ( [ -e /usr/lib/apt/methods/https ] || { apt-get update && apt-get install -y apt-transport-https; } && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 && \
    sh -c "echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list" && \
    apt-get update && \
    apt-get install -y lxc-docker-1.3.3 && \
    apt-get install -y wget && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*)

RUN (   wget -q http://mirror.vorboss.net/apache/kafka/0.8.1.1/kafka_2.8.0-0.8.1.1.tgz -O /tmp/kafka_2.8.0-0.8.1.1.tgz && \
        tar xfz /tmp/kafka_2.8.0-0.8.1.1.tgz -C /opt && \
        rm -fv /tmp/kafka_2.8.0-0.8.1.1.tgz)

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_2.8.0-0.8.1.1
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
CMD start-kafka.sh

