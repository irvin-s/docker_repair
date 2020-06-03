ARG NODE_VER="8.10.0"

FROM node:${NODE_VER}-alpine as RELEASE

ENV HOME_DIR "opt/qix-graphql"

RUN mkdir -p $HOME_DIR
WORKDIR $HOME_DIR

COPY package.json ./

RUN npm config set loglevel warn
RUN npm install --quiet --only=production --no-package-lock

COPY /src ./src/

ARG PORT=3004
ENV PORT=${PORT}
EXPOSE $PORT

CMD ["npm", "run", "start"]
