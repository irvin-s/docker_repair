# vi Dockerfile  
FROM alpine:3.5  
MAINTAINER DingHan dinghan0406@gmail.com  
  
# install dnsmasq  
RUN apk --no-cache add dnsmasq  
EXPOSE 53 53/udp  
  
ENTRYPOINT ["dnsmasq", "--no-daemon", "--keep-in-foreground"]  
  

