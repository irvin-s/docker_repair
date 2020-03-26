FROM alpine:3.7  
ENV SPEEDTEST_VERSION 1.0.7  
RUN set -x \  
&& apk add --no-cache --update \  
ca-certificates \  
python3 \  
&& pip3 install speedtest-cli==$SPEEDTEST_VERSION  
  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

