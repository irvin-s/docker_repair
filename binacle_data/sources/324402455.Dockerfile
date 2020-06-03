FROM node:9.0.0

# RUN apt-get update && apt upgrade && \
#   apt install -y bash git openssh-client
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm install --silent
COPY . /usr/src/app
ENV NODE_ENV production
RUN npm run build
RUN npm install -g serve
EXPOSE 5000
CMD "serve" "-s" "build"
