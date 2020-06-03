FROM kyma/docker-nginx

# Example if you wanna swap the default server file.
# COPY path/to/your/default /etc/nginx/sites-enabled/default

COPY dist/ /var/www

CMD 'nginx'
