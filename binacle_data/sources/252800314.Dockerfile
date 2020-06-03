FROM alpine:3.6  
LABEL maintainer="Jonathan Doherty" \  
git="2.13.0"  
  
RUN apk add --no-cache \  
git \  
bash  
  
COPY .gitconfig /root/  
COPY .git-credentials /root/  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]

