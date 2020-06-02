FROM node:boron

ARG GIT_BRANCH="develop"

# Create app directory
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Install app dependencies (Doing this first takes advantage of Docker's caching of layers)
RUN apt-get install -y make gcc g++ python git

RUN git clone https://github.com/hydrotik/node-hapi-react-redux-sass-typescript-mongo-webpack-hmr-gulp --depth 1 -b ${GIT_BRANCH} . && git submodule update --init
RUN cd plugins/auth_plugin && npm link && cd ../../
RUN cd plugins/navbobulator && npm link && cd ../../
RUN cd plugins/contentedit && npm link && cd ../../
RUN npm install && npm link navbobulator auth_plugin contentedit

EXPOSE 8000
EXPOSE 8001
EXPOSE 8008

CMD [ "npm", "start" ]
