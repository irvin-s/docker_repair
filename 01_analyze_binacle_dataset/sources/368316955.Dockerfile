FROM codeExecution:base

MAINTAINER Vasil Dininski

RUN sudo apt-get update
RUN sudo apt-get install php5 -y