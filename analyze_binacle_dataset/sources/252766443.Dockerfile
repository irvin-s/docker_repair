FROM alpine:3.5  
  
RUN apk update && \  
apk add build-base \  
openssl \  
openssl-dev \  
libffi \  
libffi-dev \  
ca-certificates \  
python-dev \  
py-pip \  
ansible \  
krb5 \  
krb5-dev \  
vim && \  
pip install --upgrade \  
kerberos \  
requests_kerberos \  
pywinrm \  
pywinrm[credssp] \  
requests[security] \  
requests-credssp \  
certifi && \  
update-ca-certificates  
  
# For Python LDAP support (For dynamic inventory)  
RUN apk add py2-pyldap  
  
ENTRYPOINT "/bin/sh"  

