FROM jfloff/thrike:8.5

LABEL maintainer="jfloff@inesc-id.pt"

###################
# Build Server
#
WORKDIR /home/calculator
# cache gradle build dependencies - is less often changed than code
ADD build.gradle /home/calculator
RUN gradle getDependencies
# add all code and build
ADD . /home/calculator
RUN gradle build && \
    cp build/libs/calculator.war /usr/local/tomcat/webapps/