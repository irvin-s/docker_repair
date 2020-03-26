FROM ubuntu
MAINTAINER robert berry, robert@relsys.io

# Install dependencies
RUN apt-get -y update && apt-get install -y locales && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get -y install build-essential postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3 ruby ruby-dev git nodejs gnuplot cron
RUN gem install bundler
RUN pg_dropcluster 9.3 main && pg_createcluster --locale en_US.UTF-8 9.3 main

# Add config files
ADD ./ /opt/pgantenna
ADD ./docker/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD ./docker/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
ADD ./docker/pgantenna /etc/init.d/pgantenna
ADD ./docker/start.sh /opt/start.sh
ADD ./docker/crons.conf /opt/crons.conf

RUN crontab /opt/crons.conf

# Setup service script for pgantenna
RUN chmod 755 /etc/init.d/pgantenna

# Add plotpg extension and update postgres permissions
RUN git clone https://github.com/no0p/plotpg.git; cd plotpg; make; sudo make install
RUN chown postgres:postgres /etc/postgresql/9.3/main/pg_hba.conf; chown postgres:postgres /etc/postgresql/9.3/main/postgresql.conf;

# Setup Rails
RUN service postgresql start; cd /opt/pgantenna; bundle install; rake db:create RAILS_ENV=production; rake db:reset RAILS_ENV=production; rake assets:precompile RAILS_ENV=production

EXPOSE 24831

ENTRYPOINT /bin/bash /opt/start.sh

# Run with docker run -p 24831:24831 -p 80:80 pgantenna 
#
# Note on building for public repository: 
#   docker build -t no0p/pgantenna .
#   docker push no0p/pgantenna
# 
