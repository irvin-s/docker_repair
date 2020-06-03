FROM alpine:3.5  
ADD bin/ /usr/local/lightjbl/  
WORKDIR /usr/local/lightjbl/  
  
EXPOSE 8080  
CMD ["./lightjbl", "-i", "rose.html"]  
  

