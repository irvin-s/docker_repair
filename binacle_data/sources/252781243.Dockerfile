FROM alpine  
  
RUN apk add --no-cache lsyncd  
  
CMD ["lsyncd", "/etc/lsyncd/lsyncd.lua"]  

