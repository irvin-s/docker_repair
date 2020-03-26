FROM node:10

# install nginx and so on...
RUN apt-get update -qq && \
  apt-get install -y build-essential nodejs git autoconf locales locales-all curl vim openssl libssl-dev libyaml-dev libxslt-dev cmake htop libreadline6-dev nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /app

COPY package*.json .

COPY yarn.lock .

COPY config ./config

RUN npm install && yarn run dll

COPY . .

RUN yarn build

RUN mv dist /etc/nginx/dist

COPY nginx.conf.example /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
