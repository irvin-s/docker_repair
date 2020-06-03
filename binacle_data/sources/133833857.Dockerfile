FROM ubuntu:12.04
MAINTAINER jmaicher@mail.upb.de

# -- Base ---------------------------------------------

ADD mage-env/provision/base_provision /usr/local/bin/base_provision
RUN chmod +x /usr/local/bin/base_provision
RUN base_provision


# -- PhantomJS ----------------------------------------

ADD mage-env/provision/phantomjs_provision /usr/local/bin/phantomjs_provision
RUN chmod +x /usr/local/bin/phantomjs_provision
RUN phantomjs_provision


# -- Ruby ---------------------------------------------

ADD mage-env/provision/ruby_provision /usr/local/bin/ruby_provision
RUN chmod +x /usr/local/bin/ruby_provision
RUN ruby_provision


# -- Node ---------------------------------------------

ADD mage-env/provision/nodejs_provision /usr/local/bin/nodejs_provision
RUN chmod +x /usr/local/bin/nodejs_provision
RUN nodejs_provision


# -- Nginx --------------------------------------------

ADD mage-env/provision/nginx_provision /usr/local/bin/nginx_provision
RUN chmod +x /usr/local/bin/nginx_provision
RUN nginx_provision
ADD mage-env/provision/nginx/nginx.conf /etc/nginx/nginx.conf
ADD mage-env/provision/nginx/mage.prod /etc/nginx/sites-enabled/mage.prod
ADD mage-env/provision/nginx/mage.dev /etc/nginx/sites-enabled/mage.dev


# -- Mage ---------------------------------------------

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD mage-desktop/Gemfile Gemfile
ADD mage-desktop/Gemfile.lock Gemfile.lock
RUN su mage -l -c "NOKOGIRI_USE_SYSTEM_LIBRARIES=true bundle install"
 
# Everything up to here was cached. This includes
# the bundle install, unless the Gemfiles changed.
# Now copy the app into the image.
ADD . /mage
RUN chown -R mage:www-data /mage
WORKDIR /mage

# Important: Run as login shell because of rvm
RUN /bin/bash -l -c "/mage/build"

# Important: Run as login shell because of rvm
CMD /bin/bash -l -c "/mage/run"

