# Zeit Now in a container
# https://zeit.co/now
#
# ```bash
# docker run --rm -it \
#   -v $PWD:/now \
#   andrewsardone/docker-zeit-now
# ```
#
# Make sure to mount your `now` credentials at the /now directory of the
# container.

From node:latest
MAINTAINER Andrew Sardone <andrew@andrewsardone.com>
LABEL description="A Docker image to run Zeit's Now -- https://zeit.co/now"

USER node
WORKDIR /home/node

# Pack your credentials into the image. Make sure to copy them into the sibling
# git ignored now-creds directory.
COPY --chown=node now-creds .now

RUN npm install now@11.0.3
ENV PATH="/home/node/node_modules/now/download/dist:${PATH}"

CMD [ "now" ]
