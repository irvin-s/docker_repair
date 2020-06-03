FROM containerize/godep  
  
ADD . /go/src/imgprox  
  
WORKDIR /go/src/imgprox  
  
VOLUME ["/go/src/imgprox/images", "/go/src/imgprox/outputs"]  
  
RUN godep restore && go build -o imgprox main.go  
  
ENTRYPOINT ["./imgprox"]

