FROM nginx:1.11.5
MAINTAINER maintainer@email.com

WORKDIR /etc/nginx

# Remove default conf
RUN rm -v nginx.conf

# Copy nginx.conf and mime.types
COPY config/nginx /etc/nginx/

# Copy entrypoint
# COPY build-tools/scripts/docker-entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# Copy application
COPY build/ /usr/share/nginx/html/

# ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
