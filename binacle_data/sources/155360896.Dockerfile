FROM ubuntu:trusty
MAINTAINER  Jessica Frazelle <github.com/jfrazelle>

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    curl \
    python-software-properties \
    software-properties-common \
    --no-install-recommends

# install node
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    nodejs \
    --no-install-recommends

# add the source
COPY . /src

# install modules
RUN cd /src; npm install --production

WORKDIR /src

CMD npm start