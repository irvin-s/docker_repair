FROM registry.access.redhat.com/rhel7:latest
MAINTAINER Johnathan Kupferer <jkupfere@redhat.com>

ENV JAVA_VERSION=${JAVA_VERSION:-1.8.0} \
    JAVA_TYPE=${JAVA_TYPE:-oracle}

ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-${JAVA_TYPE}

RUN yum --disablerepo=* \
        --enablerepo=rhel-7-server-rpms \
        --enablerepo=rhel-7-server-extras-rpms \
        --enablerepo=rhel-7-server-optional-rpms \
        --enablerepo=rhel-7-server-thirdparty-oracle-java-rpms \
      install -y \
      java-${JAVA_VERSION}-${JAVA_TYPE}-devel \
      java-${JAVA_VERSION}-${JAVA_TYPE}-jdbc && \
    yum clean all
