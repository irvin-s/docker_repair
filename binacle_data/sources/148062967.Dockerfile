# Gradecraft web application Docker image
#
# VERSION       2.0
# ENVIRONMENT	production

# ~~~~ Image base ~~~~
FROM quay.io/gradecraft/secrets:production
MAINTAINER Nagumalli Sundeep <nagumals@umich.edu>
ENV DOCKER_FIX random
RUN gem install -v 1.17.3 bundler
RUN mkdir /gradecraft
WORKDIR /gradecraft/
ADD Gemfile /gradecraft/Gemfile
ADD Gemfile.lock /gradecraft/Gemfile.lock
RUN bundle install
COPY . /gradecraft
RUN cp /intermidiate/gradecraft_saml_idp.pem /gradecraft/gradecraft_saml_idp.pem
RUN cp /intermidiate/gcsha256.key /gradecraft/gcsha256.key
RUN cp /intermidiate/gcsha256.crt /gradecraft/gcsha256.crt
RUN cp /intermidiate/www.gradecraft.com.key /gradecraft/www.gradecraft.com.key
RUN cp /intermidiate/www.gradecraft.com.crt /gradecraft/www.gradecraft.com.crt
RUN cp /intermidiate/database.yml /gradecraft/config/database.yml
RUN cp /intermidiate/mongoid.yml /gradecraft/config/mongoid.yml
RUN cp /intermidiate/puma.rb /gradecraft/config/puma.rb
RUN cp /intermidiate/Procfile /gradecraft/Procfile
RUN printf  "if [ \$WEBRESQUE = 'WEB' ]\nthen \n RAILS_ENV=production bundle exec rake resque:scheduler &\n/mounts3.sh\nservice nginx start\npuma\nelse \n RAILS_ENV=production bundle exec rake resque:scheduler & \nbundle exec rake resque:work >> resque.log\nfi" > /gradecraft/start.sh
RUN chmod +x /gradecraft/start.sh
RUN crontab /etc/cron.d/trim-cron
CMD cron && tail -f /var/log/cron.log
RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN RAILS_ENV=production bundle exec rake db:migrate
ENTRYPOINT /gradecraft/start.sh
