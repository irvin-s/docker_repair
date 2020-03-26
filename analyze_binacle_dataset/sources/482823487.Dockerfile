FROM ruby:2.3.3
RUN apt-get update \
  && apt-get install -y postgresql postgresql-contrib libpq-dev curl bash git jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu
WORKDIR /opt
RUN git clone --depth=1 https://github.com/FarmBot/Farmbot-Web-API
RUN cd Farmbot-Web-API && bundle install
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash
RUN apt-get install -y nodejs build-essential
WORKDIR /opt/Farmbot-Web-API
# ./install_fronted error · Issue #199 · FarmBot/farmbot-web-frontend
# https://github.com/FarmBot/farmbot-web-frontend/issues/199
RUN ./install_frontend.sh
ADD database.yml config/
ADD start.sh /start.sh
RUN chmod +x /start.sh
