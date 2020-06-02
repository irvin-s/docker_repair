# This is a comment
FROM ubuntu:14.04
MAINTAINER Cui Pengfei
RUN apt-get update && apt-get install -y tree
CMD echo "tree and git, only text2"
