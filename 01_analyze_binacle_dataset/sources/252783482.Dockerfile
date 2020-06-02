FROM alpine  
ADD drone-bearychat.sh /bin/  
RUN chmod +x /bin/drone-bearychat.sh  
RUN apk -Uuv add curl ca-certificates  
ENTRYPOINT /bin/drone-bearychat.sh

