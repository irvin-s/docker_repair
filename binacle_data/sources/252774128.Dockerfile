FROM amarburg/golang-ffmpeg:wheezy-1.8  
RUN go get -v -d github.com/amarburg/go-lazycache  
  
WORKDIR $GOPATH/src/github.com/amarburg/go-lazycache  
  
# Install and run easyjson  
RUN go get -u github.com/mailru/easyjson/...  
RUN go generate -v  
  
WORKDIR $GOPATH/src/github.com/amarburg/go-lazycache/app  
RUN go get -d .  
RUN go build -o lazycache .  
RUN cp lazycache $GOPATH/  
  
VOLUME [ "/srv/overlay", "/srv/image_store"]  
ENV LAZYCACHE_PORT=8080  
WORKDIR $GOPATH  
ENTRYPOINT [ "./lazycache" ]  
EXPOSE 8080  

