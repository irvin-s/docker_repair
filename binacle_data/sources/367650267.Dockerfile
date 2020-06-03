FROM debian:stretch

#ENV stretch=stretch
ENV WORKDIR=/workdir

#ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
#ENV RUBY_VERSION 2.3.1
ENV RBENV_ROOT=/rbenv
ENV PATH="$RBENV_ROOT/bin:$PATH"

ENV CONFIGURE_OPTS --disable-install-doc

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get -q -y update \
    && apt-get -q -y install \
      bash \
      build-essential \
      gnupg2 \
      curl \
      procps \
      git \
      libssl-dev \
      libreadline-dev \
      zlib1g-dev


run git clone git://github.com/rbenv/rbenv.git $RBENV_ROOT \
    && git clone git://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build \
    && git clone git://github.com/jf/rbenv-gemset.git $RBENV_ROOT/plugins/rbenv-gemset

#@    && cd $RBENV_ROOT \
#@    && src/configure \
#@    && make -C src 

#    && chgrp -R rbenv $RBENV_ROOT \
#    && chmod -R g+rwxXs $RBENV_ROOT \
#    && cd $RBENV_ROOT \

#    && adduser --disabled-password --gecos "" --uid 1000 stretch \
#    && adduser stretch rbenv

    #&& echo 'eval "$(rbenv init -)"' | tee -a /home/stretch/.bashrc \
    #&& chown stretch.stretch /home/stretch/.bashrc
#
#RUN cd /tmp \
#    && curl -L -o ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz \
#    && tar -xzvf ruby-install-0.6.1.tar.gz \
#    && cd ruby-install-0.6.1 \
#    && sudo make install

#RUN su -c 'gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3' stretch
#run su -c '\curl -sSL https://get.rvm.io | bash -s -- --ruby=2.4.1' stretch



#RUN mkdir /workdir \
#    && chown stretch.stretch /workdir

#USER stretch

WORKDIR /workdir

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
