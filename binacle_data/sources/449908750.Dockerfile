FROM phusion/passenger-ruby21:0.9.10

EXPOSE 3000

# Enable nginx/passenger
RUN rm -f /etc/service/nginx/down

# Disable SSH
# Some discussion on this: https://news.ycombinator.com/item?id=7950326
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install rails dependencies
RUN apt-get update
RUN apt-get -y install sqlite3 libsqlite3-dev

# Copy in app and config files
ADD nginx/rails-env.conf /etc/nginx/main.d/rails-env.conf
ADD nginx/webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD . /home/app/webapp

# Install gems
WORKDIR /home/app/webapp
RUN bundle install

# Install "production" database (for demo purposes only)
WORKDIR /home/app/webapp
RUN RAILS_ENV=production rake db:migrate

# Run runit init system
CMD ["/sbin/my_init"]
