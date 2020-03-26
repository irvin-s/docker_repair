FROM node:9.5.0

RUN apt-get update && \
    apt-get install -y fonts-liberation \
    gconf-service libappindicator1 libasound2 \
    libatk-bridge2.0-0 libatk1.0-0 libcups2 \
    libdbus-1-3 libgconf-2-4 libgtk-3-0 \
    libnspr4 libnss3 libx11-xcb1 libxss1 \
    lsb-release xdg-utils libappindicator3-1

RUN wget https://dl.google.com/linux/direct/google-chrome-beta_current_amd64.deb
RUN dpkg -i google-chrome-beta_current_amd64.deb

RUN apt-get install -y apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

RUN update-ca-certificates

WORKDIR /opt/app

COPY . .

RUN yarn install

ENTRYPOINT ["yarn"]
