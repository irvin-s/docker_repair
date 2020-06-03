FROM alpine:3.6  
LABEL maintainer "Benjamin Stein <info@diffus.org>"  
RUN apk add --no-cache wrk ca-certificates  
ENTRYPOINT ["wrk"]  

