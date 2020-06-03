FROM gliderlabs/alpine:latest  
  
ADD requirements.txt /tmp/requirements.txt  
  
RUN apk --update add ca-certificates python py-pip \  
&& pip install -r /tmp/requirements.txt \  
&& rm -rf /tmp/requirements.txt \  
&& apk del py-pip \  
&& apk del py-setuptools \  
&& rm -rf /var/cache/apk/* \  
&& rm -rf /tmp/*  
  
ADD buildkite-cloudwatch-metrics-publisher /usr/bin/  
  
ENTRYPOINT ["buildkite-cloudwatch-metrics-publisher"]  

