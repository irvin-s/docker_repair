FROM alpine

RUN apk add --update bash git curl rsync && \
    rm -f /tmp/* /etc/apk/cache/*

ENV PATH="/directus/bin:${PATH}"

WORKDIR /directus/

COPY --chown=root:root ./bin/ /directus/bin/
RUN find /directus/bin/ -type f -exec chmod +x {} \;

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["directus"]
