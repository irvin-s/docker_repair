FROM scratch  
MAINTAINER Dharmit Shah <dshah@redhat.com>  
  
COPY gocounter /  
  
EXPOSE 80  
CMD ["/gocounter"]  

