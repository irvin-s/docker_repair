FROM php:7.0-apache

COPY index.html manifest.json worker.js package.json composer.json /var/www/html/

COPY aurelia_project /var/www/html/aurelia_project
COPY icons           /var/www/html/icons
COPY img             /var/www/html/img
COPY php             /var/www/html/php
COPY scripts         /var/www/html/scripts
COPY src             /var/www/html/src

WORKDIR /var/www/html

RUN npm install -g aurelia-cli sass
RUN npm install --loglevel=error
RUN sass src/styles.scss > styles.css
RUN au build
