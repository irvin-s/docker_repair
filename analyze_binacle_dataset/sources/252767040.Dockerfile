FROM alpine  
  
RUN apk update && apk upgrade  
RUN apk add figlet  
  
ENTRYPOINT ["figlet"]  
CMD ["--help"]

