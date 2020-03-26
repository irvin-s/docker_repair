FROM astronomerio/aries:1.0.1
MAINTAINER astronomer <greg@astronomer.io>

# Install node.js
ENV NODE_VERSION=6.9.5-r1

RUN apk --update upgrade \
    && apk add --no-cache \
        git \
        nodejs=$NODE_VERSION

# Execute task-runner installed with the activity with arguments provided from CMD.
# We might want to split out the executor and the utils into aries-executor and aries-utils.
ENTRYPOINT ["node_modules/.bin/aries-data"]
