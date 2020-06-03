FROM delner/ruby:2.3.1
MAINTAINER David Elner <david@davidelner.com>

# Install dependencies
RUN apt-get update && \
    apt-get install -qq -y nodejs software-properties-common

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable && apt-get update && \
    apt-get install -qq -y nginx=1.10.1-0+xenial0 && \

    # Cleanup
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

# Turn off nginx and set owner
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install DB libs
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev libmysqlclient-dev && \

    # Cleanup
    apt-get clean && \
    cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* && \
    truncate -s 0 /var/log/*log

# Install Rails App
WORKDIR /app
# Defer installation of gems to run time
# So we can take advantage of gem data volume
# ONBUILD ADD Gemfile /app/Gemfile
# ONBUILD ADD Gemfile.lock /app/Gemfile.lock
# ONBUILD RUN bundle install
ONBUILD ADD . /app

# Add default unicorn config
ADD unicorn.rb /app/config/unicorn.rb

# Add default foreman config
ADD Procfile /app/Procfile
