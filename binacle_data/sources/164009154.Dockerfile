FROM finnlabs/rails:latest

# precompile the assets - assuming we don't need a DB for asset precompilation
RUN su app -c 'RAILS_ENV=production bundle exec rake assets:precompile'

# configure database
COPY /docker/database.yml /home/app/webapp/config/database.yml
RUN chown app /home/app/webapp/config/database.yml

# add startup script for running migrations etc.
COPY /docker/setup_app.sh /etc/my_init.d/20_setup_app.sh
