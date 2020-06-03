FROM cmp1234/python:2.7.13-alpine3.6  
  
RUN set -ex; \  
deps=' \  
PyYAML==3.11 \  
certifi==2017.7.27.1 \  
elasticsearch-curator==5.1.2 \  
urllib3==1.15.1 \  
'; \  
pip install $deps; \  

