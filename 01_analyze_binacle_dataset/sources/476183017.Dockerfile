FROM node:10 as base
RUN apt-get update && apt-get -y install unzip texinfo
RUN apt-get install -y libssl-dev libffi-dev
RUN apt-get install -y build-essential
RUN apt-get install -y libc6-dev
RUN apt-get install -y libgmp-dev
# TODO: build from github archive src, avoid requring npm?
RUN npm install esy@next
# TODO: possible to insert esy call here using 'base' package.json, in order to avoid building ocaml + deps every time?
COPY . /reason-server
WORKDIR /reason-server
RUN /node_modules/.bin/esy install
RUN /node_modules/.bin/esy build:docker
FROM scratch
# TODO: 'esy which'?
COPY --from=base /reason-server/_esy/default/store/*/*/install/default/bin/ReasonServerApp.exe /server
ENTRYPOINT ["/server"]
