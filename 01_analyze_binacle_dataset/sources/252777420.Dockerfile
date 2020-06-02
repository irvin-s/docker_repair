FROM python:alpine  
MAINTAINER Christian Günther <cguenther.tu.chemnitz@gmail.com>  
  
# Install dependencies so they get cached with the image  
VOLUME /var/lib/conan  
RUN apk update && \  
apk add musl-dev gcc openldap-dev && \  
pip install --no-cache-dir conan conan_ldap_authentication  
RUN adduser -S conan -h /var/lib/conan -s /bin/sh  
# Run uwsgi listening on port 9300  
EXPOSE 9300  
  
COPY ./entrypoint.sh /entrypoint.sh  
CMD ["/bin/sh", "/entrypoint.sh"]  

