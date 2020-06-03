FROM library/golang:1.4.2  
RUN go get github.com/cdarwin/dumbserve  
RUN go install github.com/cdarwin/dumbserve  
  
ENTRYPOINT ["dumbserve"]  
CMD ["-h"]  

