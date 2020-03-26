FROM node:6.5.0

WORKDIR /app
ENV PATH="/app/node_modules/.bin:$PATH"
CMD ["node", "standup-irc.js"]

# Install node requirements and clean up unneeded cache data
COPY package.json package.json
RUN npm install -d

# Finally copy in the app's source file
COPY . /app
