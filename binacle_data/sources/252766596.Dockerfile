FROM alpine as build  
  
RUN apk --no-cache add\  
git\  
bash\  
nodejs-npm\  
&& rm -rf /var/cache/apk/*  
  
ENV LANG C.UTF-8  
WORKDIR /tmp  
  
RUN set -ex\  
&& git clone https://github.com/glowing-bear/glowing-bear\  
&& cd glowing-bear\  
&& npm install  
  
FROM fnichol/uhttpd  
COPY \--from=build /tmp/glowing-bear /www  
  

