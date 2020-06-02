FROM pierreprinetti/wp-cli

# ENV PATH $PATH:/bin
RUN set -x \
      && apk add --update bash jq curl

COPY ./scripts/ /scripts

ENTRYPOINT [""]

CMD ["echo"]
