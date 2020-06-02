FROM mhart/alpine-node:6

# uncomment for dev
# RUN apk update && \
#     apk add make gcc g++ python git

RUN mkdir /src
ADD package.json /src/

WORKDIR /src

# comment in dev
RUN apk update && \
    apk add make gcc g++ python git && \
    npm install --production && \
    apk del make gcc g++ python git

# uncomment for dev
# RUN npm install --production

COPY . /src

EXPOSE 3000
ENV SWIM_PORT=7799
ENTRYPOINT ["node", "baseswim.js"]
