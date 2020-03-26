FROM alpine:latest  
  
  
ADD parser /parser  
ADD event_schema.json /  
RUN ["chmod", "777" ,"/event_schema.json"]  
  
CMD ["/parser"]  
  

