FROM entelectchallenge/base:2019

RUN apt-get update -y

RUN apt-get install default-jdk -y

RUN apt-get install maven -y
RUN apt-get install sbt -y