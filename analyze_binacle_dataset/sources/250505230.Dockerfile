FROM node:6.4

# Workdir
RUN mkdir -p /project
WORKDIR /project


# Install global dependencies and create user
RUN npm set progress=false && \
    npm install -g typescript@2.0.2 webpack-cli webpack-dev-server tslint@next

# Install dependencies
COPY package.json /project/
RUN npm install

EXPOSE 8080


