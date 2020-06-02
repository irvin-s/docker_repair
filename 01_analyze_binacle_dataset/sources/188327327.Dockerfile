FROM node:0.10-slim
EXPOSE <%= ports.join(' ') %>
ENV NODE_ENV production

# Install service dependencies
# NOTE: These steps depends highly on service in question

# Switch to non-root user and create a directory for it
RUN useradd -m -d /service service
RUN mkdir -p /service
RUN chown -R service.service /service
USER service

# Install and package production deps; see the extensive 
# file ignore list at .dockerignore
WORKDIR /service
COPY package.json README.md /service/
RUN npm install --production
COPY . /service

# Use the start script defined in package.json
CMD [ "npm", "start" ]