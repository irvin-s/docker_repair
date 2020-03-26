FROM ruby

RUN \
        # install sudo (used by generated script)
        apt-get update && apt-get install sudo && \
        # install travis-cli
        gem install travis --no-rdoc --no-ri && \
        # install bundler
        gem install bundler && \
        # install travis-build
        git clone --depth 1 https://github.com/travis-ci/travis-build.git /opt/travis-build && \
        bundle install --gemfile /opt/travis-build/Gemfile && \
        mkdir $HOME/.travis && \
        ln -s /opt/travis-build $HOME/.travis/travis-build

WORKDIR /data
ENTRYPOINT ["travis", "compile", "--skip-version-check", "--skip-completion-check"]
