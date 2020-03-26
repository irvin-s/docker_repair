# Build
#  docker build -t fe .
# Use
#  curl -sSL https://raw.githubusercontent.com/dosel/t/i/p | bash -s start
#  docker run --rm -ti --net container:zalenium fe
#  curl -sSL https://raw.githubusercontent.com/dosel/t/i/p | bash -s stop
FROM node:7

RUN apt-get -qqy update \
  && apt-get -qqy install \
    git-core \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/diemol/frontend_testing.git

RUN ln -sf /frontend_testing/page-objects/js-webdriverio/complete /js-webdriverio

WORKDIR /js-webdriverio
RUN npm install

CMD ["npm", "test"]
