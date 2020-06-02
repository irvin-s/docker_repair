FROM debian:wheezy-slim  
RUN apt-get update && apt-get -y upgrade && apt-get -y install ruby1.9.3

