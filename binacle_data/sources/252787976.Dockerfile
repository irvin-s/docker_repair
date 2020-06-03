FROM gliderlabs/alpine:3.3  
ENTRYPOINT ["/bin/logspout"]  
VOLUME /mnt/routes  
EXPOSE 80  
RUN apk add --update alpine-sdk bash && rm -rf /var/cache/apk/*  
  
COPY . /src  
RUN cd /src && ./build.sh "$(cat VERSION)"  
  
ONBUILD COPY ./build.sh /src/build.sh  
ONBUILD COPY ./modules.go /src/modules.go  
ONBUILD RUN cd /src && ./build.sh "$(cat VERSION)-custom"  

