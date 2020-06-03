FROM node:8-alpine  
  
RUN addgroup kinesalite && adduser -H -D -G kinesalite kinesalite  
  
# see https://github.com/npm/npm/issues/17851 for npm permissions issues when  
# installing global packages as root, --unsafe-perm resolves this  
RUN apk add --update g++ make python \  
&& npm install -g --unsafe-perm --build-from-source kinesalite \  
&& apk --purge -v del g++ make python \  
&& rm -rf /var/cache/apk/*  
  
USER kinesalite  
  
EXPOSE 4567  
ENTRYPOINT ["kinesalite"]  

