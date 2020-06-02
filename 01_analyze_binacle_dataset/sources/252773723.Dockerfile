FROM alpine:3.4  
COPY ./leak.sh /  
EXPOSE 1500  
ENTRYPOINT ["/leak.sh"]  

