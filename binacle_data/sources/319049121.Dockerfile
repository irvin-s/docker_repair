FROM node:10.10.0
WORKDIR /usr/src
RUN mkdir -p homepage/src
RUN mkdir faucet
COPY ./workspaces/homepage/package.json ./homepage
COPY ./workspaces/faucet/Readme.md ./faucet
RUN ls -al
RUN (cd homepage && yarn)
COPY ./workspaces/homepage/ ./homepage/
RUN (cd homepage && ls -al && yarn build)
