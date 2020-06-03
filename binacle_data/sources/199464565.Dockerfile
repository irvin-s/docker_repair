FROM ubuntu:14.04
MAINTAINER Isaac Aymerich <isaac.aymerich@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Common
RUN apt-get update -y \
    && apt-get install python-software-properties -y \
    && apt-get update -y

##NFS Installation
RUN apt-get update -qq && apt-get install -y nfs-kernel-server runit inotify-tools -qq \
    && mkdir -p /exports \
    && mkdir -p /etc/sv/nfs && echo "/exports *(rw,sync,insecure,fsid=0,no_subtree_check,no_root_squash)" | tee /etc/exports \
    && sed -i 's#RPCMOUNTDOPTS="--manage-gids"#RPCMOUNTDOPTS="--manage-gids -p 15300"#g' /etc/default/nfs-kernel-server

ADD nfs.init /etc/sv/nfs/run
ADD nfs.stop /etc/sv/nfs/finish
RUN chmod -R +x /etc/sv/nfs

##Java Install
RUN apt-get update && apt-get install software-properties-common -y && add-apt-repository ppa:webupd8team/java -y \
    && apt-get update && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && apt-get install oracle-java7-installer -y

# Define commonly used JAVA_HOME variable
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

##Web Orchestrator installation
ADD web.init /etc/sv/web/run
ADD web.stop /etc/sv/web/finish
RUN chmod -R +x /etc/sv/web

RUN apt-get update && apt-get -y install git maven \
    && cd /tmp/ && git clone https://github.com/segator/PlexRemoteTranscoderOrchestrator.git \
    && cd PlexRemoteTranscoderOrchestrator \
    && mkdir /etc/transcoder_orchestrator \
    && cp -R scripts/* /etc/transcoder_orchestrator \
    && mvn clean install \
    && cd target \
    && cp PlexCloudTranscoding.jar /usr/bin/ && chmod +x /usr/bin/PlexCloudTranscoding.jar \
    && rm -R /tmp/PlexRemoteTranscoderOrchestrator \
    &&  apt-get -y purge git maven && apt-get -y autoremove && rm -rf /root/.m2


COPY entry-point.sh /usr/bin/entry-point.sh
RUN  chmod +x /usr/bin/entry-point.sh

EXPOSE 8800/tcp 6006/tcp 111/udp 111/tcp 2049/tcp 15300/tcp 15300/udp

CMD ["entry-point.sh"]
