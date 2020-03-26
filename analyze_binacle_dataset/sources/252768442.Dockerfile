FROM alpine:latest  
MAINTAINER Alexandre Dumont <adumont@gmail.com>  
  
RUN apk -v update && \  
apk -v add py-pip && \  
pip install --upgrade pip && \  
pip install subliminal==0.7.5 && \  
rm -rf ~/.cache && \  
rm -rf /var/cache/apk && \  
echo "user:x:1001:1001::/home/user:/bin/sh" >> /etc/passwd && \  
echo "user:x:1001:" >> /etc/group && \  
mkdir -p /home/user && \  
chown user:user /home/user && \  
cd /usr/lib/python2.7/site-packages/subliminal/providers && \  
sed -i "s#\\['permissive'\\]#\"html5lib\"#" *.py  
  
USER user  
  
ENTRYPOINT ["subliminal"]  

