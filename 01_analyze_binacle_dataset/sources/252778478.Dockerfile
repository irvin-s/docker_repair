FROM xataz/alpine:3.3  
MAINTAINER arckosfr <contact@lemark.xyz>  
  
CMD ["usr/bin/tini","--","startup"]  
VOLUME ["/home/urlwatch/.urlwatch"]  
ENV UID=1000 GID=1000  
RUN apk add --update \  
python3 \  
git \  
ca-certificates \  
supervisor \  
&& wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 \  
&& pip3 install urlwatch \  
&& apk del git && rm -rf /var/cache/apk/*  
ADD rootfs /  
ADD startup /usr/bin/startup  
ADD urlwatch1 /usr/bin/urlwatch1  
RUN chmod +x /usr/bin/startup /usr/bin/urlwatch1

