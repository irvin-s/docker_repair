FROM alpine:latest

RUN apk add --no-cache zip

LABEL "com.github.actions.name"="Zip"
LABEL "com.github.actions.description"="Produce a zip archive from files"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/inextensodigital/actions"
LABEL "homepage"="http://github.com/inextensodigital"
LABEL "maintainer"="IED <contact@inextenso.digital>"

ENTRYPOINT ["zip"]
