# Run with  
# -v /path/to/custom/settings.py:/opt/bot-rss-atom/settings.py  
FROM alpine  
  
ADD src /opt/bot-rss-atom  
WORKDIR /opt/bot-rss-atom  
  
RUN \  
apk update \  
&& apk add python py-pip \  
&& pip install -r requirements.txt \  
&& apk del py-pip  
  
CMD python ./feedfetcher.py  

