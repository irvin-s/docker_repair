FROM alpine:3.3  
RUN apk add --update bash curl && \  
rm -rf /var/cache/apk/*  
  
COPY src /src  
  
WORKDIR /src  
  
ENTRYPOINT ["./run.sh"]  
  
CMD ["register"]  

