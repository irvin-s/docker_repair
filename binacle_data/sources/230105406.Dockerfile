FROM java:openjdk-8-jdk
MAINTAINER Heiner Peuser <heiner.peuser@weweave.net>

ENV LANG C.UTF-8
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV TW_HOME /opt/tubewarder

RUN apt-get update && \
    apt-get install -y supervisor && \
    apt-get clean 

RUN cd /tmp && \
    curl -v -j -k -L -H "Cookie:oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip > jce_policy-8.zip && \
    unzip jce_policy-8.zip && \
    cp UnlimitedJCEPolicyJDK8/*.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -d $TW_HOME tubewarder
RUN mkdir -p $TW_HOME

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD tubewarder.conf $TW_HOME
ADD tubewarder-swarm.jar $TW_HOME
ADD libs/*.jar $TW_HOME/libs/
RUN chown -R tubewarder:tubewarder $TW_HOME

EXPOSE 8080
ENTRYPOINT ["/usr/bin/supervisord", "-n"]
