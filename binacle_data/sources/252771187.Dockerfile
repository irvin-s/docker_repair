## Reference:  
## [1] https://github.com/sameersbn/docker-gitlab  
FROM centos:centos6  
MAINTAINER Jazz Wang <jazzwang.tw@gmail.com>  
  
COPY app/ /app/  
RUN /app/setup/install  
  
ENTRYPOINT ["/app/init"]  

