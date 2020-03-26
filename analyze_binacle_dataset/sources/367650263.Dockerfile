FROM mgreenly/alpine-ruby:2.4.1 

RUN apk update \
    && apk add \
      build-base \
      libffi-dev \
      py-pygments \
    && gem install \
      rouge \
      jekyll \ 
    && adduser -D -u1000 jekyll \
    && mkdir /workdir \
    && chown jekyll.jekyll /workdir

USER jekyll

WORKDIR /workdir

CMD /usr/bin/env jekyll
