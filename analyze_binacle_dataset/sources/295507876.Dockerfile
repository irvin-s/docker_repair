FROM stratio/ubuntu-base:16.04
MAINTAINER Stratio QA - Team "qa@stratio.com"

ARG VERSION

COPY docker/docker-entrypoint.sh /dcos/docker-entrypoint.sh
COPY target/dcosTokenGenerator-${VERSION}-jar-with-dependencies.jar /dcos/dcosTokenGenerator.jar

RUN apt-get update && apt-get install -y build-essential libssl-dev libffi-dev python3-dev sshpass
RUN pip3 install dcoscli==$(echo $VERSION | awk -F'-' '{print $1}')

RUN chmod a+x /dcos/docker-entrypoint.sh && chmod a+x /dcos/dcosTokenGenerator.jar

WORKDIR /dcos

EXPOSE 22

ENTRYPOINT ["/dcos/docker-entrypoint.sh"]
