FROM alpine  
RUN mkdir -p /src && \  
apk add --no-cache cppcheck  
WORKDIR /src  
ENTRYPOINT ["/bin/sh", "-c"]  

