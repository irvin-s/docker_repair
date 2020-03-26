FROM node:10.13.0-stretch

LABEL maintainer="Avi Flax <avi.flax@fundingcircle.com>"
LABEL description="Node 10 (LTS), Clojure 1.9, and Chromium 70 on Debian Stretch"

WORKDIR /tmp

# Install dependencies of the Renderer and Clojure
#
# Version numbers are hard-coded because if we use environment variables, the
# ENV statements prevent all subsequent layers from being cached, because
# they’re considered deterministic. I’d prefer that the version numbers were
# stated more declaratively, all in one place, and there’s probably a way to do
# that without ENV but I couldn’t find a straightforward way to do so.
#
# We’re including rlwrap just because it’s handy in case we need to run a REPL
# in a container, for debugging.
RUN apt-get update -yq
RUN apt-get install -yq \
      chromium=71.0.3578.80-1~deb9u1 \
      openjdk-8-jre=8u181-b13-2~deb9u1 \
      rlwrap

# Install Clojure
RUN wget -q https://download.clojure.org/install/linux-install-1.10.0.403.sh \
      && chmod +x linux-install-1.10.0.403.sh \
      && ./linux-install-1.10.0.403.sh \
      && rm linux-install-1.10.0.403.sh
