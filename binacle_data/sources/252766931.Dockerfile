FROM ubuntu:14.04  
  
RUN apt-get update && apt-get install -y golang-go  
RUN apt-get install bash  
ADD . /app  
WORKDIR /app  
RUN go build -o http  
RUN mkdir /app/www  
RUN touch /app/www/index.htm  
  
ENV PORT 8000  
EXPOSE $PORT  
  
CMD ["/app/http"]  

