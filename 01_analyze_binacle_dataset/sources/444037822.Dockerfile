FROM centos:7

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-10-14

RUN yum upgrade -y && \
    # curl https://sdkrepo.atlassian.com/atlassian-sdk-stable.repo > /etc/yum.repos.d/atlassian-sdk.repo && \
    # yum install -y atlassian-plugin-sdk
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    curl -L https://marketplace.atlassian.com/download/plugins/atlassian-plugin-sdk-tgz > atlassian-plugin-sdk.tgz && \
    tar -zxvf atlassian-plugin-sdk.tgz -C /opt/ && \
    ln -s /opt/atlassian-plugin-sdk-* /opt/atlassian-plugin-sdk

RUN yum install -y git

VOLUME /data
WORKDIR /data
CMD ["/opt/atlassian-plugin-sdk/bin/atlas-run"]
