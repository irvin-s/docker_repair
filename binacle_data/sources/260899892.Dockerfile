FROM nginx:1.11.10-alpine

# remove default configurations and change ownership
RUN rm -rf /etc/nginx/conf.d/* && \
    chown -R nginx:nginx /var/cache/nginx && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

# copy application files
COPY stage/ /

# set user
USER nginx:nginx
