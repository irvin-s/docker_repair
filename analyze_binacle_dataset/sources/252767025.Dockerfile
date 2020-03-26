FROM aldrinleal/godeb-base  
  
RUN go get github.com/aldrinleal/revproxy/revproxy  
  
EXPOSE 80  
CMD /app/revproxy -port 80  

