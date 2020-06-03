FROM hashicorp/packer:light  
MAINTAINER Jesse DeFer <packer-ansible@dotd.com>  
  
RUN apk --no-cache add ansible git openssh-client  
RUN adduser -D -u 1000 jenkins  

