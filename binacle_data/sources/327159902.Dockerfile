FROM nginx:alpine
MAINTAINER cgb
COPY dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
