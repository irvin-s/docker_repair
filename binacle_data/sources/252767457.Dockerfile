FROM golang:1.8-onbuild  
RUN mkdir -p /web  
COPY web /web  
RUN chmod -R 700 /web  
  
EXPOSE 80  
CMD [ "go-wrapper", "run", "--port", "80" ]  
  

