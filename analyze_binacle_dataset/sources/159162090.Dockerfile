FROM howareyou/ruby:2.0.0-p247

ADD ./ /var/apps/q

RUN \
  echo 'export RACK_ENV="production"' >> /.profile ;\
  echo 'export RAILS_ENV="production"' >> /.profile ;\
  . /.profile ;\
  rm -fr /var/apps/q/.git ;\
  cd /var/apps/q ;\
  bundle install --local ;\
# END RUN

CMD . /.profile && cd /var/apps/q && foreman start

EXPOSE 5000
