FROM codeExecution:base

MAINTAINER Vasil Dininski

RUN sudo apt-get update
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:fkrull/deadsnakes
RUN sudo apt-get update
RUN sudo apt-get install python3.3 -y
