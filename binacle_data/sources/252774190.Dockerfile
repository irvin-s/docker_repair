FROM gliderlabs/alpine:3.4  
ENTRYPOINT ["/bin/logspout"]  
VOLUME /mnt/routes  
EXPOSE 80  
COPY . /src  
RUN cd /src && ./build.sh "$(cat VERSION)"  
RUN apk --update upgrade && \  
apk add curl ca-certificates && \  
update-ca-certificates && \  
rm -rf /var/cache/apk/*  
  
ONBUILD COPY ./build.sh /src/build.sh  
ONBUILD COPY ./modules.go /src/modules.go  
ONBUILD RUN cd /src && ./build.sh "$(cat VERSION)-custom"  

