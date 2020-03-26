FROM blang/golang-alpine  
  
MAINTAINER Allan Costa "allan@cloudwalk.io"  
RUN apk add bash  
  
RUN \  
go get github.com/codegangsta/martini;\  
go get github.com/PuerkitoBio/gocrawl;\  
go get github.com/cloudwalkio/go-ir;  
#RUN  
ADD server.go /src/omg-search/server.go  
ADD startup.sh /src/omg-search/startup.sh  
  
# Build Go server's binary  
RUN \  
cd /src/omg-search/;\  
go build;  
#RUN  
WORKDIR /src/omg-search/  
  
# Save logs to LOG_DIR_SEARCH  
ENV LOG_DIR_SEARCH /var/log/docker/search  
  
# Default port to run it  
ENV OMG_SEARCH_PORT 5000  

