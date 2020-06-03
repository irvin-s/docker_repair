FROM node:8.5.0

ENV NODE_ENV="development"

# These steps ensure that yarn is only run when package.json changes
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
