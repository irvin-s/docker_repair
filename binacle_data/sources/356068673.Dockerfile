FROM node:4-onbuild
# replace this with your application's default port
COPY ./package.json /usr/src/app/
EXPOSE 8888
