FROM nginx
WORKDIR /usr/share/nginx/html
ADD src.tar ./
EXPOSE 80
