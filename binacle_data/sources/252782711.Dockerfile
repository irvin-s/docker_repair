FROM golang  
ADD main.go /  
RUN go build /main.go  
CMD ["./main"]  

