FROM node:8-alpine  
  
RUN addgroup dynalite && adduser -H -D -G dynalite dynalite  
  
# see https://github.com/npm/npm/issues/17851 for npm permissions issues when  
# installing global packages as root, --unsafe-perm resolves this  
RUN apk add --update g++ make python \  
&& npm install -g --unsafe-perm --build-from-source dynalite \  
&& apk --purge -v del g++ make python \  
&& rm -rf /var/cache/apk/*  
  
USER dynalite  
  
EXPOSE 4567  
ENTRYPOINT ["dynalite"]  

