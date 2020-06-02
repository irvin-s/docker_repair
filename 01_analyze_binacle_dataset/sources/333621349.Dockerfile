FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jdk-11.28

LABEL description="Example that shows how to install fc4-tool and render a diagram."
LABEL maintainer="Avi Flax <avi.flax@fundingcircle.com>"

# Install the dependencies of fc4-tool
RUN apt-get -yq update \
      && apt-get -yq install --no-install-recommends chromium-browser

# Install fc4-tool
RUN curl -L -s \
      https://github.com/FundingCircle/fc4-framework/releases/download/release_2018-12-11_772/fc4-tool-linux-d021ef9.tar.gz \
      | tar xzv

COPY *.yaml ./

RUN fc4/fc4 render *.yaml
