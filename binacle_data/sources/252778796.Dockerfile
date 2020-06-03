FROM alpine:3.3  
MAINTAINER David M. Lee <leedm777@yahoo.com>  
  
RUN apk --update add \  
python \  
py-pip \  
jq \  
curl \  
bash \  
&& pip install --upgrade awscli \  
&& rm -rf /var/cache/apk/*  
  
COPY etcd-aws-cluster /etcd-aws-cluster  
  
ENTRYPOINT ["/etcd-aws-cluster"]  

