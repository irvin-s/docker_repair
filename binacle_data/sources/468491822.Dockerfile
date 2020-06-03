FROM node:10-alpine

LABEL com.github.actions.name="Framer Bridge Action"
LABEL com.github.actions.description="This Action is a wrapper for the Framer CLI to build and publish packages to the Framer Store."
LABEL com.github.actions.icon="git-commit"
LABEL com.github.actions.color="gray-dark"

RUN apk add --update jq && rm -rf /var/cache/apk/*

RUN yarn global add framer-cli@latest

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
