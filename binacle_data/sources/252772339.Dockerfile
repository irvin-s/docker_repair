FROM alpine  
  
RUN apk --no-cache add pdftk  
  
WORKDIR /files  
  
ENTRYPOINT ["pdftk"]  

