FROM ruby:2.3-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk add --no-cache openssh \
    && gem install --no-rdoc --no-ri capistrano \
    && rm -rf  $GEM_HOME/cache/*

ENV dir /root
WORKDIR ${dir}

RUN mkdir -p ${dir}/source
ADD bin/cap ${dir}/cap

CMD ["sh"]
