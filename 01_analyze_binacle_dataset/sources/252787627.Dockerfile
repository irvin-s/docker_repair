FROM bruceadams/kale  
MAINTAINER Bruce Adams <bruce.adams@acm.org>  
  
# `wget` needs `openssl` to handle https  
# The crawler uses `bash` for its launch scripts.  
RUN apk add --no-cache bash openssl  
  
# Get and install the current Watson Crawler release  
RUN mkdir -p /opt/ibm && \  
cd /opt/ibm && \  
wget https://ibm.biz/watson-crawler-zip && \  
mv watson-crawler-zip crawler.zip && \  
unzip crawler.zip && \  
rm crawler.zip && \  
ln -s crawler-* crawler && \  
ln -s /opt/ibm/crawler/bin/* /usr/local/bin  
  
# Setup so we can be run with any UID.  
RUN adduser -D crawler  
RUN chmod -Rc 777 /home/crawler  
WORKDIR /home/crawler  

