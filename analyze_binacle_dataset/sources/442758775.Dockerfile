FROM ruby:2.1.5

RUN apt-get update -y && \
  apt-get install -y nodejs python python-setuptools && \
  easy_install sphinx && \
  useradd publisher --home /home/publisher --create-home && \
  chown -R publisher:publisher ${GEM_HOME}

USER publisher

# Override some inherited settings that assume a root user.
RUN echo 'gem: --no-rdoc --no-ri' >> "/home/publisher/.gemrc"
ENV PATH ${GEM_HOME}/bin:${PATH}

ADD docker/src2html/scripts /home/publisher/scripts
ADD docker/src2html/config/baseconfig.yml /home/publisher/baseconfig.yml
ADD Gemfile /home/publisher/Gemfile
ADD Gemfile.lock /home/publisher/Gemfile.lock

RUN bundle install --gemfile=/home/publisher/Gemfile

EXPOSE 4000

CMD ["/bin/bash", "/home/publisher/scripts/build.sh"]
