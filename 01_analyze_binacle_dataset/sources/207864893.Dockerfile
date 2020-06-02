FROM node:4

RUN npm install -g drupal-project-loader

RUN mkdir /data

WORKDIR /data

ENTRYPOINT ["drupal-project-loader"]
