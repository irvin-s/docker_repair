FROM nginx:alpine

RUN apk --no-cache add curl

HEALTHCHECK --interval=5s CMD curl --fail http://localhost:80/ || exit 1
