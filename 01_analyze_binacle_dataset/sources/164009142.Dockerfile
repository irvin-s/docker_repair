FROM phusion/passenger-ruby21:0.9.15
MAINTAINER Finn GmbH <info@finn.de>

# install td-agent with some useful plugins
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
RUN /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-logentries
RUN /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-loggly
RUN /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-elasticsearch

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::Options::="--force-confold" install \
        libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable and configure nginx
RUN rm -f /etc/service/nginx/down
COPY /docker/disable-version.conf /etc/nginx/conf.d/disable-version.conf
COPY /docker/webapp.conf /etc/nginx/sites-enabled/webapp.conf

# Disable default nginx host so app can be accessed without specific host
RUN rm /etc/nginx/sites-enabled/default


COPY /docker/setup_app_logs.sh /etc/my_init.d/10_setup_app_logs.sh
# Startup script for generating nginx config that passes through env vars
COPY /docker/nginx_pass_environment.rb /etc/my_init.d/11_nginx_pass_environment.rb
COPY /docker/nginx_config_from_environment.rb /etc/my_init.d/12_nginx_config_from_environment.rb

# fig puts invalid hostnames into your hosts file for container linking
# until the issue is fixed, this converts them by replacing underscores with hyphens
# see related fig issue: https://github.com/docker/fig/issues/229
COPY /docker/sanitize_hosts.sh /etc/my_init.d/13_sanitize_hosts.sh

ADD /docker/runit_fluentd /etc/service/fluentd/run
ADD /docker/td-agent.conf /etc/td-agent/td-agent.conf

RUN su app -c 'mkdir /home/app/{bundle,bundle-cache,webapp}'
WORKDIR /home/app/webapp

# Install bundle (assuming bundle packaged to vendor/cache)
ONBUILD COPY vendor/cache /home/app/bundle-cache/vendor/cache
ONBUILD COPY Gemfile /home/app/bundle-cache/Gemfile
ONBUILD COPY Gemfile.lock /home/app/bundle-cache/Gemfile.lock
ONBUILD RUN chown -R app /home/app/bundle-cache
ONBUILD RUN su app -c 'cd /home/app/bundle-cache && \
                       bundle install \
                            --jobs=4 \
                            --path=/home/app/bundle \
                            --no-cache'

ONBUILD COPY / /home/app/webapp
ONBUILD RUN cp -a /home/app/bundle-cache/.bundle /home/app/webapp
ONBUILD RUN mkdir -p log tmp public

# set permissions
ONBUILD RUN chown --recursive app log tmp public
