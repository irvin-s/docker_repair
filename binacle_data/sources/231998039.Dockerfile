FROM node:6.9

ENV HOME=/home/node
ENV PORT=3030

COPY package.json \
     npm-shrinkwrap.json \
     config \
     public \
     src \
     test $HOME/callmyreps_server/
COPY wait-for-it.sh $HOME/
RUN chown -R node:node $HOME/* && chmod +x $HOME/wait-for-it.sh

USER node

WORKDIR $HOME/callmyreps_server
RUN npm install && npm cache clean

CMD [ "/home/node/wait-for-it.sh", "db:27017", "--", "node", "src/" ]