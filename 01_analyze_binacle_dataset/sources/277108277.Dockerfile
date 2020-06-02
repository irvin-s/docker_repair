FROM node:8-alpine

RUN apk add --no-cache curl && \
    curl -sfL \
    https://github.com/openfaas-incubator/of-watchdog/releases/download/0.0.4/of-watchdog-armhf > /usr/bin/fwatchdog && \
    chmod +x /usr/bin/fwatchdog

WORKDIR /root/

# Turn down the verbosity to default level.
ENV NPM_CONFIG_LOGLEVEL warn

# Wrapper/boot-strapper
COPY package.json       .
RUN npm i

# Function
COPY index.js           .
RUN mkdir -p ./function

COPY function/*.json    ./function/
WORKDIR /root/function
RUN npm i || :
WORKDIR /root/
COPY function           function

WORKDIR /root/

ENV cgi_headers="true"

ENV write_debug=true
ENV read_debug=true

ENV fprocess="node index.js"
ENV afterburn=true
ENV mode=afterburn
RUN touch /tmp/.lock

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1
EXPOSE 8080
CMD ["fwatchdog"]
