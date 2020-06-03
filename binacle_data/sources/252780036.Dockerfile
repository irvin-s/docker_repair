FROM ubuntu:latest AS download  
ADD download.sh /  
RUN bash /download.sh  
  
FROM ayanamist/centos5-devtools2:latest AS build  
ARG MAKE_J  
ADD build.sh /  
COPY \--from=download /download /build  
RUN scl enable devtoolset-2 /build.sh  
  
FROM centos:centos5  
COPY \--from=build /usr/local/bin /usr/local/bin

