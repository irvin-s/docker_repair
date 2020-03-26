FROM alpine:latest  
ADD wait /wait  
CMD ["sh", "/wait"]  

