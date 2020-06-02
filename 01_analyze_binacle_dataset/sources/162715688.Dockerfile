FROM austenito/ruby:2.1.2

RUN apt-get update

RUN mkdir /postgres
ADD Berksfile /postgres/Berksfile
ADD solo.json /postgres/solo.json
ADD solo.rb /postgres/solo.rb

WORKDIR /postgres

RUN bash -c 'source /usr/local/share/chruby/chruby.sh; chruby 2.1.2'
RUN berks vendor ./cookbooks
RUN chef-solo -c solo.rb -j solo.json

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 5432

USER postgres

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

