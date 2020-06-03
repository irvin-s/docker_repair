FROM node:0.10-slim
ENV NODE_ENV production

# Install client dependencies
# NOTE: These steps depends highly on client in question

# Switch to non-root user and create a directory for it
RUN useradd -m -d /client client
RUN mkdir -p /client
RUN chown -R client.client /client
USER client

# Install and package production deps; see the extensive 
# file ignore list at .dockerignore
WORKDIR /client
COPY package.json README.md /client/
RUN npm install --production
COPY . /client

# Use the start script defined in package.json
CMD [ "npm", "start" ]