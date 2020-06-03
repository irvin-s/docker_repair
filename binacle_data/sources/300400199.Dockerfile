FROM node:4

RUN apt-get update -y
RUN apt-get install git -y
RUN apt-get install nginx -y
RUN apt-get install vim -y
RUN mkdir -p /var/www/html/
RUN rm -rf /var/lib/apt/lists/*
RUN npm install -g pm2

WORKDIR /var/www/html/

RUN git clone -b gh-pages https://github.com/weexteam/incubator-weex.git /var/www/html/weex/
RUN cd weex/ && git checkout gh-pages

ADD webserver.conf /etc/nginx/conf.d/
ADD weexsite.conf /etc/nginx/nginx.conf
ADD deploy.sh /var/www/html/hook/
ADD server.js /var/www/html/hook/
ADD hookserver.json /var/www/html/hook/package.json

RUN cd hook && npm install
EXPOSE 80 7777

# RUN pm2 start /var/www/html/hook/server.js
# RUN pm2 save
# RUN pm2 startup
# CMD ["pm2", "start", "/var/www/html/hook/server.js"]

CMD ["nginx", "-g", "daemon off;"]
