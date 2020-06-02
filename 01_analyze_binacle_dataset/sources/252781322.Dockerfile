FROM ruby:2.3-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
ENV HAML_LINT_VERSION=0.27.0  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/* \  
&& gem install haml_lint -v ${HAML_LINT_VERSION}  
  
WORKDIR /app  
VOLUME /app  
  
COPY haml-lint.sh /haml-lint.sh  
COPY .haml-lint.yml /.haml-lint.yml  
ENTRYPOINT ["/haml-lint.sh"]  

