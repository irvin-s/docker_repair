FROM nginx:1.13.12-alpine@sha256:9d46fd628d54ebe1633ee3cf0fe2acfcc419cfae541c63056530e39cd5620366

ADD /dist /usr/share/nginx/html
ADD /nginx.conf /etc/nginx/conf.d/default.conf
