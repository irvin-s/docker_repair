FROM gliderlabs/alpine:latest  
RUN apk --update add mc nano \  
&& sed -i 's/^tty/#tty/' /etc/inittab  
ENTRYPOINT ["/sbin/init"]  

