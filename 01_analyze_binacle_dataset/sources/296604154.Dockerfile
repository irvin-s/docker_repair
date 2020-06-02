from mhart/alpine-node:7.7.1
label name=skynet-scrub-server
maintainer Development Seed <dev@developmentseed.org>
add ./package.json /app/package.json
workdir /app
run npm install
add . /app
cmd npm start
