FROM mhart/alpine-node:10

RUN npm i -g tumblr-toolkit

ENTRYPOINT ["tt"]
