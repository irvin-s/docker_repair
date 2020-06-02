FROM node:9.6-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
ENV SASS_LINT_VERSION=1.12.1  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/* \  
&& npm install -g sass-lint@${SASS_LINT_VERSION}  
  
WORKDIR /app  
VOLUME /app  
  
COPY sass-lint.sh /sass-lint.sh  
ENTRYPOINT ["/sass-lint.sh"]  

