FROM opensuse/leap:15.0
MAINTAINER Maximilian Meister "mmeister@suse.de"

RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
    libxml2-devel libxslt-devel \
    sqlite3-devel gcc make ruby-devel ruby2.5-rubygem-bundler \
    ca-certificates ca-certificates-mozilla git-core \
    ruby2.5-devel

RUN mkdir -p /nailed/data/config
VOLUME /nailed/data

# add the git tree with the app
ADD . /nailed
WORKDIR /nailed

# set Ruby 2.5 as the default version
RUN ln -sf /usr/bin/ruby.ruby2.5 /usr/local/bin/ruby

# add the dependencies
RUN bundle config build.nokogiri "--use-system-libraries"
RUN bundle install --path /nailed/vendor/bundle

# redirect the config to the volume
RUN rm -rf config && ln -s /nailed/data/config config

# Github and Bugzilla configuration
ENV OCTOKIT_NETRC /nailed/data/config/.netrc
ENV HOME /nailed/data/config

EXPOSE 4567
CMD ["make", "all"]
