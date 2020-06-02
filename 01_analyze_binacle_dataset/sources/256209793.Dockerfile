FROM ruby:alpine
LABEL "com.github.actions.name"="Publish Gem"
LABEL "com.github.actions.description"="Publish gem to rubygems.org"
LABEL "com.github.actions.icon"="truck"
LABEL "com.github.actions.color"="green"
LABEL "repository"="https://github.com/koshigoe/brick_ftp"
LABEL "homepage"="https://github.com/koshigoe/brick_ftp"
LABEL "maintainer"="koshigoe <koshigoeb@gmail.com>"

RUN apk update -q \
        && apk add -q --no-cache curl jq git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
