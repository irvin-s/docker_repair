FROM alpine:edge  
RUN apk -U add openvpn && rm -rf /var/cache/apk/*  
ENTRYPOINT ["/usr/sbin/openvpn"]  

