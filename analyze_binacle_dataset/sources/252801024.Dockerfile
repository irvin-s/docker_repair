# aws  
#  
# AWS client  
#  
# docker run -it --rm \  
# -v $HOME/.aws:/root/.aws \  
# --log-driver none \  
# --name awscli \  
# draco1114/aws "$@"  
#  
#  
FROM alpine:latest  
MAINTAINER Michael Thomas <draco1114@gmail.com>  
  
RUN apk update && apk add \  
ca-certificates \  
groff \  
less \  
python \  
py-pip \  
&& rm -rf /var/cache/apk/* \  
&& pip install --upgrade pip -q \  
&& pip install awscli -q \  
&& mkdir -p /root/.aws \  
&& { \  
echo '[default]'; \  
echo 'output = json'; \  
echo 'region = $AMAZON_REGION'; \  
echo 'aws_access_key_id = $AMAZON_ACCESS_KEY_ID'; \  
echo 'aws_secret_access_key = $AMAZON_SECRET_ACCESS_KEY'; \  
} > /root/.aws/config  
  
ENTRYPOINT [ "aws" ]

