FROM node:8.10.0-alpine

# Set a working directory
WORKDIR /src

COPY ./package.json .
COPY ./yarn.lock .

# Install Node.js dependencies
RUN yarn install --production --no-progress

# Copy application files
COPY ./dist .

# Run the container under "node" user by default
USER node

CMD [ "node" ]
