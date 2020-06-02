# Use the official node image
#  from https://hub.docker.com/r/library/node/
FROM node:10.5.0-alpine

# install nginx and link logs
RUN apk --no-cache add nginx bash \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log \
  && mkdir /var/run/nginx

# nginx
ADD conf/default.conf /etc/nginx/conf.d/default.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

# start script
ADD scripts/start.sh /start.sh

# create app directory
WORKDIR /usr/src/app

# support (npm@5+)
COPY package*.json ./

# install
RUN npm install --only production

# assets
COPY . .

EXPOSE 80

CMD ["/start.sh"]
