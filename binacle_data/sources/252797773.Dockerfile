FROM alpine:3.5  
ENV ANSIBLE_HOSTS=/ansible/hosts  
  
RUN apk --update add python py-pip ansible bash ca-certificates \  
&& pip install --upgrade pip boto boto3 dnspython \  
&& update-ca-certificates 2&>1 > /dev/null  
  
COPY ansible /ansible  
COPY cloudformation /cloudformation  
COPY sh/* /usr/local/bin/  

