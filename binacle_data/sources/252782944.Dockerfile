FROM golang:alpine AS build  
RUN apk add --no-cache make git  
WORKDIR /app/src  
COPY Makefile .deps ./  
RUN make deps-install  
  
COPY . ./  
RUN make  
  
FROM alpine  
RUN apk add --no-cache ca-certificates  
COPY \--from=build /app/src/docker-sni-proxy /usr/local/bin/docker-sni-proxy  
  
EXPOSE 80  
EXPOSE 443  
CMD ["docker-sni-proxy"]  

