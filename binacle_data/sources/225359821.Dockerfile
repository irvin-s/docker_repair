FROM centos:latest
MAINTAINER PubNative Team <team@pubnative.net>

ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV JAVA_TOOL_OPTIONS "-Dfile.encoding=UTF8"
ENV CONFIG ""

# UTILS, JAVA & MESOS
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel subversion cyrus-sasl-md5 gettext && \
  rpm -Uvh http://repos.mesosphere.com/el-testing/7/x86_64/RPMS/mesos-0.28.2-1.0.45.rc1.centos701406.x86_64.rpm && \
  yum -y install mesos

# SINGULARITY SERVICE
RUN mkdir -p /SingularityService/target && \
  cd /SingularityService/target && \
  curl -O https://s3.amazonaws.com/applift-public-spark-distributions/SingularityService-0.13.0-shaded.jar

CMD ["java","-jar","/SingularityService/target/SingularityService-0.13.0-shaded.jar","server","singularity_config.yml"]
