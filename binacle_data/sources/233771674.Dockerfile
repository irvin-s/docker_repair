FROM ruby:2.3.1

RUN gem install multibinder

CMD /usr/local/bundle/bin/multibinder /run/multibinder.sock