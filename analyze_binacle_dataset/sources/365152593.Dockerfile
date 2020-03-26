FROM maven:3.3.9-jdk-8-alpine
MAINTAINER Selion <selion@googlegroups.com>

ADD . /usr/src/app
WORKDIR /usr/src/app
RUN rm Dockerfile

CMD mvn -B -q -s settings.xml test \
-Dselion.version=$SELION_VERSION \
-DSELION_BROWSER=$BROWSER \
-DsuiteXmlFile=$TEST_SUITE \
-DSELION_SELENIUM_HOST=$HUB_PORT_4444_TCP_ADDR
