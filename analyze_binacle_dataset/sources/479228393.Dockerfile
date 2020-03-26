FROM docker:stable

RUN apk add --no-cache \
        make curl jq bash git openssl

LABEL "com.github.actions.name"="Docker Make"
LABEL "com.github.actions.description"="Build docker containers using make"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/inextensodigital/actions"
LABEL "homepage"="http://github.com/inextensodigital"
LABEL "maintainer"="IED <contact@inextenso.digital>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
