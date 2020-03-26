FROM nginx:latest

MAINTAINER liuht

COPY docs/.vuepress/dist/ /usr/share/nginx/html