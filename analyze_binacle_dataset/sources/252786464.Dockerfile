FROM golang:1.8-alpine  
  
RUN apk add --no-cache git curl \  
&& curl https://glide.sh/get | sh  
  
ENTRYPOINT ["glide"]  
CMD ["-v"]  

