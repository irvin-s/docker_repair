# Simple Dockerfile for testing docker cloud repository  
FROM ubuntu:16.04  
MAINTAINER centrifugal4@gmail.com  
  
RUN apt-get update && apt-get install -y \--no-install-recommends \  
build-essential python3-dev python3-pip python3-setuptools  

