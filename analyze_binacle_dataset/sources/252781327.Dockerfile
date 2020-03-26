FROM python:2.7-alpine  
LABEL maintainer="Josh Mostafa <jmostafa@cozero.com.au>"  
  
ENV PYLINT_VERSION=1.8.2  
RUN apk add --update bash \  
&& rm -rf /var/cache/apk/* \  
&& pip install -U pylint==${PYLINT_VERSION}  
  
WORKDIR /app  
VOLUME /app  
  
COPY pylint.sh /pylint.sh  
COPY pylintrc /etc/pylintrc  
ENTRYPOINT ["/pylint.sh"]  

