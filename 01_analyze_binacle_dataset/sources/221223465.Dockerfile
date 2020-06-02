ARG image_tag=latest
ARG node_version
FROM pinterb/jq:0.0.16 AS jq
FROM elifesciences/journal_npm:${image_tag} as npm

FROM node:${node_version}

# From list at https://developers.google.com/web/tools/puppeteer/troubleshooting#chrome_headless_doesnt_launch
RUN apt-get update && apt-get install --no-install-recommends -y \
    fonts-liberation \
    gconf-service \
    libappindicator1 \
    libasound2 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgconf-2-4 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxss1 \
    libxtst6 \
    locales \
    lsb-release \
    unzip \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

COPY --from=jq /usr/local/bin/jq /usr/bin/jq

RUN mkdir -p build/critical-css

COPY --from=npm /node_modules/ node_modules/

COPY check_critical_css.sh \
    critical-css.json \
    gulpfile.js \
    ./

CMD node_modules/.bin/gulp critical-css:generate && ./check_critical_css.sh
