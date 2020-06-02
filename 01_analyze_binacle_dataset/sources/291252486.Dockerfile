FROM node:10-slim

LABEL version="1.0.0"
LABEL repository="http://github.com/actions/zeit-now"
LABEL homepage="http://github.com/actions/zeit-now"
LABEL maintainer="GitHub Actions <support+actions@github.com>"

LABEL "com.github.actions.name"="GitHub Action for Zeit"
LABEL "com.github.actions.description"="Wraps the Now CLI to enable common Now commands."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="black"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN yarn global add now

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
