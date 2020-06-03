FROM alpine as build  
RUN apk --update add curl  
  
FROM scratch  
COPY \--from=build /usr/bin/curl /curl  

