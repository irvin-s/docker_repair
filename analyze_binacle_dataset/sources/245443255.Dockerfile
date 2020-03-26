FROM node:9.11.1

RUN apt-get update -y -q && apt-get install -y build-essential && apt-get install -y python

RUN mkdir -p /app
WORKDIR /app

ENV PATH /root/.yarn/bin:$PATH
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.21.3

COPY package.json yarn.lock /app/
RUN yarn  --frozen-lockfile
COPY . /app
