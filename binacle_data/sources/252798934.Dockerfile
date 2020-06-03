FROM devicetools/golib:2.12.0  
WORKDIR /go/src/bitbucket.org/devicetools/fake-device  
  
COPY . .  
  
RUN go-wrapper download \  
&& go-wrapper install \  
&& rm -rf /go/src /go/pkg  
  
CMD ["go-wrapper", "run"]  

