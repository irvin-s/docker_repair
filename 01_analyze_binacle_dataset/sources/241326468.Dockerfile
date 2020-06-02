# Puppeteer
# docker run --rm -it --cap-add=SYS_ADMIN -v $(pwd):/work supinf/puppeteer

FROM node:9.11-slim

ENV PUPPETEER_VERESION=1.9.0 \
    NODE_PATH="/node_modules:/usr/local/lib/node_modules"

# Install tini for a proper init process
RUN url=https://github.com/krallin/tini/releases/download/v0.18.0 \
    && wget -qO /usr/local/bin/tini ${url}/tini-amd64 \
    && wget -qO /usr/local/bin/tini.asc ${url}/tini-amd64.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
    && gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
    && rm -r "${GNUPGHOME}" /usr/local/bin/tini.asc \
    && chmod +x /usr/local/bin/tini

# Install chromium & system fonts
RUN apt-get update \
    && apt-get install -y --no-install-recommends libgconf-2-4 fontconfig wget sudo \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
       >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-unstable \
       ttf-freefont fonts-ipafont-gothic \
    && mkdir -p /usr/share/fonts/emoji \
    && curl --location --silent --show-error --out /usr/share/fonts/emoji/emojione-android.ttf \
       https://github.com/emojione/emojione-assets/releases/download/3.1.2/emojione-android.ttf \
    && chmod -R +rx /usr/share/fonts/ \
    && fc-cache -fv \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/* /usr/share/locale/fi/LC_MESSAGES \
              /usr/share/icons/Adwaita/256x256/apps \
              /usr/lib/python2.7/lib2to3 \
              /usr/share/locale/ro

# Install Puppeteer
RUN export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    && npm install --global puppeteer@${PUPPETEER_VERESION} \
    && mkdir /node_modules

WORKDIR /work

# Add a user for Puppeteer
RUN groupadd -r puppeteer \
    && useradd -r -g puppeteer -G audio,video puppeteer \
    && echo 'puppeteer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/puppeteer

RUN chown -R puppeteer:puppeteer /home/puppeteer /node_modules /work

USER puppeteer

ENTRYPOINT ["tini", "--"]
CMD ["node", "/home/puppeteer/index.js"]
