FROM ruby:alpine

LABEL com.github.actions.name="RuboCop"
LABEL com.github.actions.description=""
LABEL com.github.actions.icon="code"
LABEL com.github.actions.color="red"
LABEL repository=""
LABEL maintainer="Alberto Gimeno <gimenete@gmail.com>"

COPY lib /action/lib
ENTRYPOINT ["/action/lib/entrypoint.sh"]
