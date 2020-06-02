FROM node:8-alpine as base

FROM base as builder

# Some packages (e.g. @google-cloud/profiler) require additional
# deps for post-install scripts
RUN apk add --update --no-cache curl \
    python \
    make \
    g++ 

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

FROM base

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/node_modules ./node_modules

COPY . .

EXPOSE 10301 10302 10303

ENTRYPOINT [ "node", "server.js" ]
