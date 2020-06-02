FROM alpine:3.6  
  
RUN apk --no-cache add \  
nodejs \  
nodejs-npm \  
&& npm install -g \  
nsp  
  
# Add node user/group with uid/gid 1000:  
# This is a workaround for boot2docker issue #581, see  
# https://github.com/boot2docker/boot2docker/issues/581  
RUN adduser -D -u 1000 node  
  
USER node  
  
ENTRYPOINT ["nsp"]  
  
CMD ["check"]  

