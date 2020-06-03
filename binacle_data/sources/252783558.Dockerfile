FROM python:2.7-alpine  
MAINTAINER Sami Haahtinen <ressu@ressukka.net>  
  
# Download gosu and SickGear.  
RUN apk add --update \  
ca-certificates \  
curl \  
gcc \  
gnupg \  
libxml2 \  
libxml2-dev \  
libxslt \  
libxslt-dev \  
musl-dev \  
tzdata \  
su-exec \  
&& \  
mkdir /opt && \  
TAG_NAME=$(curl -s https://api.github.com/repos/SickGear/SickGear/releases | \  
python -c "import sys, json; print json.load(sys.stdin)[0]['tag_name']") && \  
curl -SL "https://github.com/SickGear/SickGear/archive/${TAG_NAME}.tar.gz" | \  
tar xz -C /opt && \  
mv /opt/SickGear-${TAG_NAME} /opt/SickGear && \  
pip install --no-cache-dir lxml && \  
pip install --no-cache-dir -r /opt/SickGear/requirements.txt && \  
apk del \  
curl \  
gcc \  
gnupg \  
libxml2-dev \  
libxslt-dev \  
musl-dev \  
&& \  
rm -rf /var/cache/apk/*  
  
ENV APP_DATA="/data" PATH=/opt/SickGear:$PATH  
  
EXPOSE 8081  
VOLUME /data /tv /incoming  
  
COPY template /template  
COPY entrypoint.sh /  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["SickBeard.py"]  

