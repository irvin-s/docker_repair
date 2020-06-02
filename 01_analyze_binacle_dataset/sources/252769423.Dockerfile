FROM google/golang  
MAINTAINER Anthony Nowell <anthony.nowell@socrata.com>  
  
ENV DATA_DIR /data  
  
ADD docker/go-build /bin/go-build  
ADD docker/go-run /bin/go-run  
  
ADD app /gopath/src/app/  
RUN /bin/go-build  
  
EXPOSE 8080  
#CMD []  
CMD ["/bin/go-run"]  

