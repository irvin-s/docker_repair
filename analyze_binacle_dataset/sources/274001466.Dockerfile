FROM node:8-slim

# See https://crbug.com/795759
RUN apt-get update && apt-get install -yq libgconf-2-4

# Install latest chrome dev package.
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer
# installs, work.
RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb
# Install puppeteer so it's available in the container.
RUN yarn add puppeteer

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/package.json
RUN yarn install

ENV TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN
COPY ./index.js /usr/src/app/index.js
COPY ./*.* /usr/src/app/
COPY ./bot.js /usr/src/app/bot.js
COPY ./util/** /usr/src/app/util/
COPY ./lib/** /usr/src/app/lib/
COPY ./exchange/** /usr/src/app/exchange/


RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /node_modules \
    && chown -R pptruser:pptruser /usr/src/app/node_modules

# Run user as non privileged.
USER pptruser



EXPOSE 5000
CMD ["npm", "run", "start"]