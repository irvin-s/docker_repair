FROM node:8.11.1
RUN npm -g config set user root
RUN npm install -g composer-cli@0.19.8 generator-hyperledger-composer@0.19.8 composer-playground@0.19.8 yo && \
    npm cache clean --force && \
    ln -s node_modules .node_modules \
