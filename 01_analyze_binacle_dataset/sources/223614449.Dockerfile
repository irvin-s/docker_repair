# This is the base used by the build time image (vividcloud/meteor).
# As we have this base, we don't need to download Meteor every time we build the app.
# We will try to make this up-to-date, but it can be used even when is outdated, since Meteor
# will download the corresponding tool to build.

FROM jimdo/debian-with-curl
MAINTAINER VividCloud

# Build tools for rebuilding binary npm packages.
RUN apt-get update && apt-get install build-essential g++ python -y

RUN curl https://install.meteor.com | sh
