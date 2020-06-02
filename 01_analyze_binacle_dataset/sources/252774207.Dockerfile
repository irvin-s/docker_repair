FROM alpine:latest  
  
RUN apk add --no-cache bash git openssh  
  
RUN mkdir -p /git  
  
WORKDIR /git  
  
COPY docker-entrypoint.sh /bin/docker-entrypoint  
COPY git-checkout-pull.sh /bin/git-checkout-pull  
ENTRYPOINT ["docker-entrypoint"]  

