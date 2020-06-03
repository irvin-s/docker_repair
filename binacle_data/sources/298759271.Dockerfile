FROM node:6.10.2-alpine

# Copy application files
COPY ./build /usr/local/app/
WORKDIR /usr/local/app/

# Install Node.js dependencies
# For chinese user, please unmark the follow code for improving building performance
# RUN npm config set registry=http://registry.npm.taobao.org
RUN npm install

CMD [ "node", "server.js" ]
