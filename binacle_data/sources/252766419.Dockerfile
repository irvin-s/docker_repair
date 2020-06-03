## Reference:  
## [1] https://github.com/sameersbn/docker-gitlab  
FROM centos:centos6  
MAINTAINER Antonin Bruneau <antonin.bruneau@gmail.com>  
  
COPY app/ /app/  
RUN /app/setup/install  
  
ENTRYPOINT ["/app/init"]  

