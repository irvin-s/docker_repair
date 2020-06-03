# alpine:3.6  
FROM node:8.11.1-alpine  
  
# set env  
ENV NODE_ENV=development  
  
# set timezone, add tini and add express-generator  
RUN apk add --update --no-cache tzdata tini && \  
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
echo "Asia/Tokyo" > /etc/timezone && \  
apk del tzdata && \  
npm install -g express-generator@4.16.0  
  
# Tini is now available at /sbin/tini  
ENTRYPOINT [ "/sbin/tini", "--" ]  
  
WORKDIR /app  
  
EXPOSE 3000  
CMD [ "node" ]

