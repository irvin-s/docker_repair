FROM clojure:latest

RUN \
  curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - && \
  apt-get update && \
  apt-get install -y haproxy nodejs bzip2 build-essential && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /frontend

ADD project.clj /frontend/project.clj
RUN lein deps

ADD package.json /frontend/package.json
RUN npm install

ADD . /frontend

EXPOSE 14443
EXPOSE 14444

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
