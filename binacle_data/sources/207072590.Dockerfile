FROM unocha/alpine-base-nodejs

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV NODE_APP_DIR=/app

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-hubot" \
      org.label-schema.description="This service provides a hubot platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.hubot=$VERSION \
      info.humanitarianresponse.hubot.plugins="hubot-auth hubot-brain-inspect hubot-diagnostics hubot-factoids hubot-flowdock hubot-giphy-gifme hubot-google-translate hubot-help hubot-karma hubot-maps hubot-pugme hubot-redis-brain hubot-rules hubot-scripts hubot-shipit" \
      info.humanitarianresponse.hubot.depends="twilio modern-syslog"


COPY package.json /

RUN apk add --update-cache \
        git \
        nodejs-lts \
        python \
        curl \
        make \
        build-base \
        openssh-client \
        && \
    mkdir -p $NODE_APP_DIR && \
    mv /package.json $NODE_APP_DIR && \
    cd $NODE_APP_DIR && \
    mkdir -p /root/.npm && \
    npm i -g coffeescript && \
    npm i && \
    rm -rf  /root/.npm && \
    apk del git python make build-base && \
    rm -rf /var/cache/apk/*

WORKDIR ${NODE_APP_DIR}

# ENTRYPOINT ["./node_modules/.bin/hubot --name", "JebbBot", "--adapter, "flowdock"]

# Wants an SSH directory mounted.
