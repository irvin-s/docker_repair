# Dockerfile based on https://github.com/ehazlett/docker-aws-tools
FROM debian:jessie

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y --no-install-recommends wget openjdk-7-jre-headless git-core unzip

RUN wget --no-check-certificate https://get.docker.io/builds/Linux/x86_64/docker-latest \
    -O /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

RUN wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip -O /tmp/ec2tools.zip && \
    mkdir /usr/local/aws && unzip -d /usr/local/aws /tmp/ec2tools.zip && rm /tmp/ec2tools.zip && \
    mv /usr/local/aws/ec2-api-tools-* /usr/local/aws/ec2

ENV PATH /usr/local/aws/ec2/bin:$PATH
ENV EC2_HOME /usr/local/aws/ec2
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre
