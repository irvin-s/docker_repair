FROM racx/dev

ADD /config/default /usr/local/openresty/nginx/sites-enabled/

# Copy the apps into the image.
ADD code/app1 /var/www/app
ADD code/auth /var/www/auth

WORKDIR /var/www/app
RUN bundle install
