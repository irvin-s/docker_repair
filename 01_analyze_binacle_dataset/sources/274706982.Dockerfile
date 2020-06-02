FROM golang:1.9 as gobuild
WORKDIR /go/src/github.com/blaskovicz/cut-me-some-slack
COPY . .
RUN go-wrapper install ./...

FROM node:8.9
WORKDIR /go/src/github.com/blaskovicz/cut-me-some-slack
COPY --from=gobuild /go/src/github.com/blaskovicz/cut-me-some-slack .
COPY --from=gobuild /go/bin .
RUN yarn install && yarn build
EXPOSE 5091
ENV ENVIRONMENT=production PORT=5091 JWT_SECRET=test-key REACT_APP_SLACK_CHANNEL=general SLACK_TOKEN=sometoken HEROKU_APP_DOMAIN=cutmesomeslack-demo.herokuapp.com
CMD ["./cut-me-some-slack"]
