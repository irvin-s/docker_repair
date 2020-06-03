FROM nginx:alpine

# Use /etc/hostname as index.html so you can distinguish the servers
RUN rm /usr/share/nginx/html/index.html \
  && ln -s /etc/hostname /usr/share/nginx/html/index.html
