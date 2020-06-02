FROM node:9

ENV CHROME_VERSION=64.0.3282.167-1

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
  gnupg \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable=$CHROME_VERSION \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Add Chrome as a user
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install && npm cache clean --force
COPY . /usr/src/app

USER chrome

CMD [ "npm", "start" ]

EXPOSE 3000
