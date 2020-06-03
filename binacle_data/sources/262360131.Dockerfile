FROM mzpi/bucklescript:1.7.4

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
      apt-get update && \
      apt-get install -y yarn --no-install-recommends && \
      apt-get clean && \
      rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

WORKDIR /trello.md
