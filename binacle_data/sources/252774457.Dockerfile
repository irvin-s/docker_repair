FROM alpine:3.4  
VOLUME /mnt/routes  
EXPOSE 80  
COPY . /src  
RUN cd /src && ./build.sh "$(cat VERSION)"  
  
ONBUILD COPY ./build.sh /src/build.sh  
ONBUILD COPY ./modules.go /src/modules.go  
ONBUILD RUN cd /src && ./build.sh "$(cat VERSION)-custom"  
COPY entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["entrypoint.sh"]  

