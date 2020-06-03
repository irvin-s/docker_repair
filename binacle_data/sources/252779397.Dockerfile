# This is a very basic deployment for gnatsd high performance nats server  
# This image is based in the oficial google image for golang.  
FROM google/golang  
  
# Here we will get the source code of gnatsd server  
WORKDIR /gopath/src/gnatsd  
  
RUN ["go", "get", "github.com/apcera/gnatsd"]  
  
# Here we expose the default port for gnatsd. This can be overriden on the  
# "$ docker run..." command.  
EXPOSE 4222  
# And here we decide to go with the default CMD this can be override too at  
# runtime  
CMD ["/gopath/bin/gnatsd"]  
  

