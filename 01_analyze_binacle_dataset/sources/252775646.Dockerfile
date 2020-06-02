FROM google/golang  
MAINTAINER Koen Bollen <koen@blendle.com>  
  
RUN go get github.com/go-martini/martini  
RUN go get github.com/fsouza/go-dockerclient  
  
ENV DOCKERSOCKET unix:///var/run/docker.sock  
ENV ENDPOINT /  
ENV IMAGE ubuntu  
ENV CONTAINER_NAME ubuntu-test  
#ENV CMD sleep 500  
#ENV USERNAME you  
#ENV PASSWORD secret  
#ENV LINKS "your-db:db something-redis:redis"  
ENV PASS_ENV PASS_ENV  
  
EXPOSE 8080  
WORKDIR /gopath/src/app  
ADD . /gopath/src/app/  
  
ENTRYPOINT go run /gopath/src/app/main.go  

