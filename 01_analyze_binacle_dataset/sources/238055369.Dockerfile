FROM nginx:stable-alpine
RUN apk --update --no-cache add bash curl jq git