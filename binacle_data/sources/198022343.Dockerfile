FROM nginx:1.9.11
# override the default nginx config with our own
ADD nginx.assets.conf /etc/nginx/nginx.conf
ADD priv/static /var/assets
RUN mkdir /logs
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
