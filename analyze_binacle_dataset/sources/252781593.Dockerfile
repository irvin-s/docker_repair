FROM barbudo/golang  
  
# extract this to golang distributive  
RUN go get github.com/tools/godep \  
&& rm -rf $GOPATH/src/github.com/tools/godep  
  
EXPOSE 9238  
ENV SCRIPT_DIR $GOPATH/src/github.com/bearded-web/wappalyzer-script  
  
RUN mkdir -p $SCRIPT_DIR  
ADD . $SCRIPT_DIR  
RUN cd $SCRIPT_DIR && godep go build -o /go/bin/wappalyzer-script ./main.go  
  
ENTRYPOINT ["wappalyzer-script"]

