FROM node:8.5.0

# These steps ensure that yarn is only run when package.json changes
COPY ./package.json .
RUN yarn
COPY . .
