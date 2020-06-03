FROM node

ENV NODE_ENV="development"

# These steps ensure that npm install is only run when package.json changes
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
