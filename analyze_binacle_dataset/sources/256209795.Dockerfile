FROM alpine:3.8
LABEL "com.github.actions.name"="Write GitHub Release"
LABEL "com.github.actions.description"="Write merged PRs into latest GitHub Release"
LABEL "com.github.actions.icon"="edit"
LABEL "com.github.actions.color"="blue"
LABEL "repository"="https://github.com/koshigoe/brick_ftp"
LABEL "homepage"="https://github.com/koshigoe/brick_ftp"
LABEL "maintainer"="koshigoe <koshigoeb@gmail.com>"

RUN apk update -q \
        && apk add -q --no-cache curl jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
