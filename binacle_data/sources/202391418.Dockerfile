FROM node:12.0.0 as builder

RUN mkdir -p /build

WORKDIR /build

ADD . /build

RUN npm install

RUN NODE_ENV=production npm run build

###

FROM nginx:latest
COPY --from=builder /build/src /usr/share/nginx/html
