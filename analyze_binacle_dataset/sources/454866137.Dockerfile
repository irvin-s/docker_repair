FROM docker/whalesay:latest
RUN sudo apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get install -y nodejs
ENV PATH /usr/local/node/bin:$PATH
COPY ./ /src
entrypoint ["node", "/src/dist/index.js"]
