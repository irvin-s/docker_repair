FROM node:8

ADD yarn.lock /yarn.lock
ADD package.json /package.json

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin
RUN yarn

ENTRYPOINT ["/bin/sh","/tools/abigen_js/docker_run.sh"]
CMD ["run"]
