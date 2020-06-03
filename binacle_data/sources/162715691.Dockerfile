FROM austenito/ruby:2.1.2

ADD run.sh /tmp/rails-example/run.sh
RUN chmod +x /tmp/rails-example/run.sh

RUN mkdir -p /apps

VOLUME ["/apps/log/rails-example"]

CMD /tmp/rails-example/run.sh
