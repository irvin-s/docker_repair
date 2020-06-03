  
FROM iron/go:dev  
WORKDIR /app  
  
ENV SRC_DIR=/go/src/videochat/  
# Add the source code:  
ADD . $SRC_DIR  
# Build it:  
RUN cd $SRC_DIR; go build -o myapp; cp myapp /app/  
ENTRYPOINT ["./myapp"]  

