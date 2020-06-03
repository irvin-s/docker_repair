FROM progrium/busybox  
MAINTAINER Andreas Larsson  
  
ADD ./release/go-app /bin/go-app  
RUN chmod 755 /bin/go-app  
  
EXPOSE 8080  
ENTRYPOINT ["/bin/go-app"]

