FROM alpine:edge  
MAINTAINER @ebarault  
  
RUN apk --no-cache add \  
bash \  
curl \  
less \  
groff \  
jq \  
python \  
py-pip \  
py2-pip && \  
pip install --upgrade pip awscli s3cmd && \  
mkdir /root/.aws \  
&& rm -rf /var/cache/apk/*  
  
# change default shell to bash  
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd  
  
RUN apk add --update \  
zip \  
git \  
&& rm -rf /var/cache/apk/*  
  
ADD scripts/ /usr/local/bin  
  
RUN chmod +x /usr/local/bin/start-build  
RUN chmod +x /usr/local/bin/push-to-pipeline  
RUN chmod +x /usr/local/bin/aws_assume_role  

