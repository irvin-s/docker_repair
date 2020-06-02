FROM alpine:latest  
  
ADD event_schema.json /  
  
ADD event_api /event_api  
  
EXPOSE 4567  
CMD ["/event_api"]  
  

