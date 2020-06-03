FROM blacklabelops/jenkins-swarm
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Need root to build image
USER root

# Add ssl certificates
COPY www.digicert.com.pem /home/jenkins/

# install web tools
RUN yum install -y epel-release && \
    yum install -y \
    unzip \
    zip \
    gzip \
    tar \
    curl \
    python-pip \
    wget && \
    yum clean all && rm -rf /var/cache/yum/* && \
    pip install --upgrade pip

# install Amazon WS Cli
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=
ENV AWS_DEFAULT_REGION=
RUN pip install --cert /home/jenkins/www.digicert.com.pem awscli && \
    curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest && \
    chmod +x /usr/local/bin/ecs-cli

# Switch back to user jenkins
USER $CONTAINER_UID
