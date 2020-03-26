FROM scaleway/cli:latest as binary  
  
FROM alpine:latest  
RUN apk add -qU ca-certificates  
COPY \--from=binary /bin/scw /usr/bin/scw  
COPY ./entrypoint.sh /  
ENTRYPOINT [ "/entrypoint.sh" ]  
CMD [ "help" ]  

