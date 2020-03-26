FROM alpine:latest  
  
MAINTAINER Vowstar Co., Ltd. <support@vowstar.com>  
  
RUN apk --no-cache add openntpd && \  
cp /etc/ntpd.conf /etc/ntp-client.conf && \  
sed -i 's/#listen on/listen on/' /etc/ntpd.conf && \  
rm -rf /var/cache/apk/*  
  
CMD ["ntpd", "-d"]  
  
# ntpd use UDP 123 port  
EXPOSE 123  

