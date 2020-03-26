FROM scratch  
ADD main /app/  
ADD templates /app/templates  
WORKDIR /app  
CMD ["/app/main"]  
EXPOSE 8001

