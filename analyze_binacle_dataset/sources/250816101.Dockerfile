FROM node:6.5
MAINTAINER Espen Hovlandsdal <espen@hovlandsdal.com>

# Set up environment
WORKDIR /srv/mead
RUN useradd --user-group --home=/srv/mead --shell /bin/false app
ENV NODE_ENV=production

# Install app dependencies (pre-source copy in order to cache dependencies)
COPY package.json .
RUN npm install --production --silent

# Copy source files
COPY . .

# Run application
USER app
EXPOSE 8080
CMD ["/srv/mead/bin/mead.js", "--config", "config/config.js"]
