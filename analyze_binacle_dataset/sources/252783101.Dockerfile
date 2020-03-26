FROM golang:onbuild  
MAINTAINER Byron Ruth <b@devel.io>  
  
CMD ["app", "-host", "0.0.0.0", "http"]  
  
EXPOSE 5000  

