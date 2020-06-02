FROM ruby:2.2

ENV MRUBYD /opt/mruby.d
WORKDIR $MRUBYD

RUN apt-get update && \
  apt-get install llvm clang libclang-dev bison -y

RUN git clone --depth=1 https://github.com/mruby/mruby && \
  git clone --depth=1 https://github.com/jbreeden/mruby-rake-tasks && \
  git clone --depth=1 https://github.com/jbreeden/clang2json && \
  git clone --depth=1 https://github.com/jbreeden/mruby-bindings

RUN cd $MRUBYD/clang2json && rake build symlink

COPY Gemfile $MRUBYD/Gemfile
RUN bundle install

# Setup curses example
WORKDIR $MRUBYD/mruby-curses
COPY mruby-curses/Rakefile $MRUBYD/mruby-curses/Rakefile
COPY mruby-curses/build_config.rb $MRUBYD/mruby-curses/build_config.rb
COPY hooks.rb $MRUBYD/mruby-curses/mruby-bindings.in/hooks.rb
RUN bundle exec rake clang2json mruby-bindings

CMD bundle exec bash
