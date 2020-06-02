FROM bitnami/ruby:2.2.4-0
ENV REDMINE_VERSION=3.2.0

RUN curl -L http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz \
      -o /tmp/redmine-${REDMINE_VERSION}.tar.gz \
 && curl -L https://github.com/ka8725/redmine_s3/archive/master.tar.gz \
      -o /tmp/redmine_s3.tar.gz \
 && mkdir -p /home/$BITNAMI_APP_USER/redmine/ \
 && tar -xf /tmp/redmine-${REDMINE_VERSION}.tar.gz --strip=1 -C /home/$BITNAMI_APP_USER/redmine/ \
 && mkdir -p /home/$BITNAMI_APP_USER/redmine/plugins/redmine_s3 \
 && tar -xf /tmp/redmine_s3.tar.gz --strip=1 -C /home/$BITNAMI_APP_USER/redmine/plugins/redmine_s3 \
 && cd /home/$BITNAMI_APP_USER/redmine \
 && sed '/if File.exist?(database_file)/,/^end/d' -i Gemfile \
 && echo "gem 'mysql2', '~> 0.3.11'" >> Gemfile.local \
 && echo "gem 'makara', github: 'taskrabbit/makara', tag: 'v0.3.3'" >> Gemfile.local \
 && cp -a config/database.yml.example config/database.yml \
 && cp -a plugins/redmine_s3/config/s3.yml.example config/s3.yml \
 && bundle install --without development test \
 && chown -R $BITNAMI_APP_USER:$BITNAMI_APP_USER /home/$BITNAMI_APP_USER/redmine/ \
 && rm -rf /tmp/redmine-${REDMINE_VERSION}.tar.gz /tmp/redmine_s3.tar.gz

COPY run.sh /home/$BITNAMI_APP_USER/redmine/run.sh
RUN sudo chmod 755 /home/$BITNAMI_APP_USER/redmine/run.sh

WORKDIR /home/$BITNAMI_APP_USER/redmine/
CMD ["/home/bitnami/redmine/run.sh"]
