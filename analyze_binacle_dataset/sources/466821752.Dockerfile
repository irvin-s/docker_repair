FROM circleci/circleci-cli:0.1.5691-alpine
COPY ./scripts /tmp/orb-scripts
RUN apk add --no-cache bash git