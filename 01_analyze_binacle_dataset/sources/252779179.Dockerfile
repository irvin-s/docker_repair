FROM bytefader/docker-maven3-jdk8-alpine:latest  
  
RUN apk add --update nodejs && rm -rf /var/cache/apk/*  
  
CMD ["node"]  
CMD ["npm"]

