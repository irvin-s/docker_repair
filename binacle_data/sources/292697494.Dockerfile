FROM heroku/heroku:16
MAINTAINER Heroku Build Team <build@heroku.com>

RUN useradd -ms /bin/bash me
USER me

ENV HOME /home
WORKDIR /home
