FROM nginx:1.13.8-alpine

COPY WebContent/index.html /usr/share/nginx/html/index.html
COPY WebContent/res /usr/share/nginx/html/res
COPY WebContent/src /usr/share/nginx/html/src

ENTRYPOINT ["nginx", "-g", "daemon off;"]