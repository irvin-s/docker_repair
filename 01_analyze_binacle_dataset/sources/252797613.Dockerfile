FROM gliderlabs/alpine:3.4  
MAINTAINER 'Jussi Heinonen<jussi.heinonen@ft.com>'  
ADD sh/* /sh/  
ADD python/* /python/  
  
RUN apk add -U py-pip && pip install --upgrade pip && \  
apk add python-dev py-boto bash curl bind-tools && \  
pip install --upgrade awscli requests  
  
# Clean  
RUN rm -rf /var/cache/apk/*  
  
CMD /bin/bash /sh/alb-dns-registrator.sh ${CLI_ARGS}  

