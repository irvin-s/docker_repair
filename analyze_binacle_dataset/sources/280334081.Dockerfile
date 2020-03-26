FROM node:8
RUN mkdir /app
WORKDIR /app
ADD package.json /app/package.json
RUN npm install
ENV OICE_DEV 1
COPY [ ".babelrc", ".eslintrc", "index.js", "package.json", "webpack.config.js", "/app/" ]
COPY dist/ /app/dist/
COPY src /app/src/
COPY src/common/constants/key.example.js /app/src/common/constants/key.js
ARG SRV_ENV=localhost
ENV SRV_ENV ${SRV_ENV}
ARG NODE_ENV=localhost
ENV NODE_ENV ${NODE_ENV}
CMD npm run start
