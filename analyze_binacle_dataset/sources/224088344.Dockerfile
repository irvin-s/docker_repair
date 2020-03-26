FROM debian:jessie
RUN apt-get update
RUN apt-get install -y build-essential gcc-multilib g++-multilib openjdk-7-jdk zlibc git cmake libcap-dev

