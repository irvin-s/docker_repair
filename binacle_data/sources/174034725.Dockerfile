FROM smashwilson/lets-nginx
ADD nginx.conf /templates/nginx.conf
ADD vhost.sample.conf /templates/vhost.sample.conf