FROM mhart/alpine-node
RUN mkdir -p /minimal_viewer
COPY package.json /minimal_viewer/package.json
COPY webpack.config.js /minimal_viewer/webpack.config.js
WORKDIR /minimal_viewer
RUN npm install
