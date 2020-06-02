#
# Build screenshot image
#

#
# Copy gosu binary from consul-template image
#
FROM hashicorp/consul-template:0.19.5-alpine as consul-template


FROM node:8.14.0-jessie

ENV SCREENSHOT_PATH "/opt/apps/screenshot"
ENV CHROME_BIN "/usr/bin/google-chrome-stable"
ENV CHROME_VERSION "71.0.3578.98-1"


ENV IMAGE_OPTIM_DEPS "advancecomp gifsicle jpegoptim libjpeg-progs optipng pngcrush fontconfig fontconfig-config libfontconfig1 unzip build-essential g++ flex bison gperf ruby perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev"
RUN apt-get update && apt-get install -y ${IMAGE_OPTIM_DEPS} && apt-get clean

ENV PNGOUT_PKG "pngout-20130221-linux-static"
RUN wget -q http://static.jonof.id.au/dl/kenutils/${PNGOUT_PKG}.tar.gz -O /tmp/${PNGOUT_PKG}.tar.gz && \
    tar -xzpf /tmp/${PNGOUT_PKG}.tar.gz -C /tmp/ && \
    cp -f /tmp/${PNGOUT_PKG}/x86_64/pngout-static /usr/bin/pngout


# TODO: can't this go into YARN deps?
RUN npm install clean-css-cli@4.1.2 uglify-js@3.0.5

# Install chrome
ENV CHROME_APT_KEY_URL "https://dl-ssl.google.com/linux/linux_signing_key.pub"
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/chrome.list && curl -s ${CHROME_APT_KEY_URL} | apt-key add - && apt-get update && apt-get install -y google-chrome-stable=${CHROME_VERSION} && apt-get clean

# Install yarn
ENV YARN_APT_KEY_URL "https://dl.yarnpkg.com/debian/pubkey.gpg"
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && curl -s ${YARN_APT_KEY_URL} | apt-key add - && apt-get update && apt-get install -y yarn && apt-get clean

# Install latest dumb-init version
ENV DUMB_INIT_SHA256 37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9
ENV DUMB_INIT_VERSION 1.2.2
RUN wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 -O /bin/dumb-init && chmod +x /bin/dumb-init && echo "${DUMB_INIT_SHA256} /bin/dumb-init" > /tmp/dumb-init.sha256sums && sha256sum -c --quiet /tmp/dumb-init.sha256sums

# Install gosu from consul-template image
COPY --from=consul-template /bin/gosu /bin/

# Create screenshot user, used for starting the service inside container
RUN groupadd netlify && useradd netlify -m -g netlify


# Prepare workdir
RUN mkdir -p ${SCREENSHOT_PATH}
WORKDIR ${SCREENSHOT_PATH}

# Install startup scripts and config
COPY kubernetes/docker/scripts/* /usr/bin/
RUN chmod +x /usr/bin/*.sh

# Copy screenshot code to container (trigger only "yarn install" when these files change)
COPY package.json yarn.lock ${SCREENSHOT_PATH}/

# Install screenshot service
RUN yarn install

# Copy node code to container
COPY . ${SCREENSHOT_PATH}/