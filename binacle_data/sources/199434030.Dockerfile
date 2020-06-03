FROM node:6

ARG node_env=development

COPY ./ /src

WORKDIR /src
ENV NODE_ENV $node_env
ENV PATH ./node_modules/.bin:$PATH
RUN npm install
RUN bower install --allow-root --force
