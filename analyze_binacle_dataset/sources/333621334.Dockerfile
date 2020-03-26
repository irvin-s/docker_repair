# This Dockerfile is intended for running the tests. It isn’t useful for _using_
# the tool because, among other reasons, the tool requires access to your
# clipboard.

# The source for this base image is at <project-root>/.circleci/images/tool/Dockerfile
FROM quay.io/fundingcircle/clojure-node-chromium:clojure-1.10.0.403_node-10.13_debian-stretch

LABEL maintainer="Avi Flax <avi.flax@fundingcircle.com>"

WORKDIR /tool

# Copy Clojure’s deps.edn and Node’s package files then download the deps
# separately from and prior to copying the app code so that we don’t have to
# re-download deps every time the app code changes.
COPY deps.edn ./
COPY renderer/package*.json ./renderer/
COPY bin/download-test-deps bin/
RUN bin/download-test-deps

# Now copy *all* the code.
COPY . ./
