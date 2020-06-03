FROM alpine:latest  
MAINTAINER beardyjay <jay@beardyjay.co.uk>  
  
RUN apk add --update \  
ruby \  
ruby-dev \  
ruby-bigdecimal \  
build-base \  
libstdc++ \  
sqlite \  
sqlite-dev \  
&& gem install json --no-ri --no-rdoc \  
&& gem install mailcatcher -v 0.7.0.beta1 --no-ri --no-rdoc \  
&& apk del --purge ruby-dev build-base \  
&& rm -rf /var/cache/apk/*  
  
EXPOSE 1025  
EXPOSE 1080  
  
CMD ["mailcatcher", "-f", "--ip=0.0.0.0"]  

