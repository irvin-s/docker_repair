FROM ubuntu:14.04
MAINTAINER Tim Park <tpark@microsoft.com>

RUN sudo apt-get update
RUN sudo apt-get install -y git
