# WechatyBlinder
# https://github.com/zixia/wechaty-blinder
#
FROM zixia/facenet
LABEL maintainer="Huan LI <zixia@zixia.net>"

RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
      build-essential \
      dumb-init \
      fonts-arphic-ukai \
      fonts-dejavu-core \
      fonts-wqy-zenhei \
      fontconfig \
      fontconfig-config \
      git \
      jq \
      libfontconfig1 \
      moreutils \
      ttf-freefont \
      ttf-wqy-zenhei \
      ucf \
    && sudo apt-get purge --auto-remove \
    && sudo rm -rf /tmp/* /var/lib/apt/lists/*

# https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
# https://github.com/ebidel/try-puppeteer/blob/master/backend/Dockerfile
# Install latest chrome dev package.
# Note: this also installs the necessary libs so we don't need the previous RUN command.
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
      google-chrome-unstable \
    && sudo apt-get purge --auto-remove \
    && sudo rm -rf /tmp/* /var/lib/apt/lists/* \
    && sudo rm -rf /usr/bin/google-chrome* /opt/google/chrome*

RUN [ -e /workdir ] || sudo mkdir /workdir \
  && sudo chown -R "$(id -nu)" /workdir
VOLUME /workdir

RUN [ -e /blinder ] || sudo mkdir /blinder \
  && sudo chown -R "$(id -nu)" /blinder

WORKDIR /blinder

# for better image cache: no need to install wechaty again when we updating wechaty-blinder only.
RUN npm init -y > /dev/null \
  && npm install wechaty \
  && rm -fr /tmp/* ~/.npm

COPY package.json .
RUN sudo chown "$(id -nu)" package.json \
  && jq 'del(.dependencies.facenet)' package.json | sponge package.json \
  && npm install \
  && rm -fr /tmp/* ~/.npm

COPY . .
RUN npm run dist

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "node", "dist/bin/bot" ]
