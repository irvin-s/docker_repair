FROM alpine:3.5  
ENV TZ 'Asia/Shanghai'  
RUN apk upgrade --no-cache && \  
apk add --no-cache bash tzdata sniproxy && \  
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \  
echo "Asia/Shanghai" > /etc/timezone && \  
rm -rf /var/cache/apk/*  
  
COPY sniproxy.conf /etc/sniproxy.conf  
  
COPY entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /*.sh  
  
EXPOSE 443  
ENTRYPOINT ["/entrypoint.sh"]  

