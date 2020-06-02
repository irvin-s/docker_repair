FROM nginx:1.12.2-alpine  
  
RUN apk add --update --no-cache tzdata && \  
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
echo "Asia/Tokyo" > /etc/timezone && \  
apk del tzdata  
  
COPY ./nginx.conf /etc/nginx/nginx.conf  
  
COPY ./conf.d /etc/nginx/conf.d

