FROM alpine:latest  
  
MAINTAINER Alexander Olofsson <alexander.olofsson@liu.se>  
  
RUN apk update \  
&& apk add \  
ruby ruby-dev ruby-json \  
&& rm -f /var/cache/apk/* \  
&& gem install -N \  
puppet puppet-lint  
  
VOLUME /code  
  
ENTRYPOINT [ "puppet-lint" ]  
CMD [ "/code", "--no-autoloader_layout-check" ]  

