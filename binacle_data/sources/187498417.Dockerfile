#Usage example: docker run -t -i --rm --name tester -h tester --link security-server1:security-server1 --link security-server2:security-server2 13ca88916f5d ./execute_tests.sh
#Problably ./execute_tests.sh should be run with the "CMD" instruction

FROM stratio/base:test
MAINTAINER Carlos Navarro <cnavarro@stratio.com>

RUN apt-get update

RUN apt-get install -y openjdk-7-jdk

RUN apt-get install -y maven

ADD . /build

WORKDIR /build




