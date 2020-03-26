FROM node:8.4-alpine

RUN ["npm", "install", "-g", "parse-dashboard"]

ADD config.json config.json

ENTRYPOINT [ \
  "parse-dashboard", \
  "--config", "config.json", \
  "--allowInsecureHTTP" \
]
