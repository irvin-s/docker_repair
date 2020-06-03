FROM alpine  
MAINTAINER 'Aeon Builds <builds+dockerfile@aeon.io>'  
RUN apk update \  
&& apk upgrade \  
&& apk add curl ca-certificates tar \  
&& rm -rf /var/cache/apk/*  

