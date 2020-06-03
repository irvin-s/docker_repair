FROM codie/alpine64  
RUN apk add --no-cache nodejs  
ENTRYPOINT ["node"]  

