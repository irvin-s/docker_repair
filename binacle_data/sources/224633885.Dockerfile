FROM centos7/mesos-0.23.0/jdk8/jenkins1.628/base
MAINTAINER prometheus zpang@dataman-inc.com

# seng git user
RUN  git config --global user.name `whoami`  && \
     git config --global user.email "jenkins@dataman-inc.com"

# install expect
RUN  yum install -y expect && \
     yum clean all

# create dir
RUN  mkdir -p /var/lib/jenkins/plugins/ && \
     mkdir -p /root/.ssh/ && \
     chmod 755 /root/.ssh/ && \
     mkdir -p /data/run && \
     mkdir -p /data/logs

# copy
# plugin
COPY plugins/*.jpi /var/lib/jenkins/plugins/
# git use
COPY gitclone /data/run/
# remote script
ADD http://10.3.10.33/config/scripts/DM_DOCKER_URI_2.7.py /data/run/DM_DOCKER_URI.py
#COPY DM_DOCKER_URI_2.7.py /data/run/DM_DOCKER_URI.py
# jenkin run script
COPY dataman_jenkins.sh /data/run/
RUN chmod 755 /data/run/gitclone && \
    chmod 755 /data/run/DM_DOCKER_URI.py && \
    chmod 755 /data/run/dataman_jenkins.sh

ENTRYPOINT ["/data/run/dataman_jenkins.sh"]
