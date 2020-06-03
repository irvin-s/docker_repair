FROM kylemanna/openvpn:2.1.0  
MAINTAINER Keaton Choi "keaton@dailyhotel.com"  
RUN apk add --update curl && \  
rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*  

