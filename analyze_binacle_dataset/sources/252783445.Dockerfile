FROM debian:latest  
  
RUN apt-get update && apt-get -y install build-essential cmake libcgicc-dev

