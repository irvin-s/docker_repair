FROM alpine  
  
RUN apk --update add go git \  
&& export GOPATH=/gopath \  
&& go get github.com/Financial-Times/vulcand \  
&& cd $GOPATH/src/github.com/Financial-Times/vulcand \  
&& git checkout b463e95177f44858713e1da78d47cd0e32c5d6cb \  
&& go build -o /vulcand \  
&& apk del go git \  
&& rm -rf /var/cache/apk/* /gopath  
  
CMD ["/vulcand"]  

