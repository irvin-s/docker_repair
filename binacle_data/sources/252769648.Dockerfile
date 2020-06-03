FROM python:alpine  
  
LABEL maintainer="Simon Bärlocher <s.baerlocher@sbaerlocher.ch>"  
  
# Install packages  
RUN apk add --update \  
openssl-dev \  
gcc \  
libffi-dev \  
musl-dev \  
make \  
git \  
&& rm -rf /var/cache/apk/*  
  
# Install ansible  
RUN pip install ansible  
  
# Install ansible-lint  
RUN pip install ansible-lint  
  
# Install yamllint  
RUN pip install yamllint  
  
CMD ["python3"]  

