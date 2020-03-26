# Just to run tests
FROM mhart/alpine-node:9 AS base
RUN apk --update --no-cache add bash make docker git
WORKDIR /usr/src/app
COPY . ./
ENV CODECOV_TOKEN=c479672d-c901-44e3-97fe-dd246ced9966

RUN yarn install
CMD ["yarn", "test-ci"]