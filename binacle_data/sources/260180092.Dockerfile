FROM gcr.io/distroless/static

COPY marcel /usr/bin/

WORKDIR /var/lib/marcel/
ENTRYPOINT ["marcel"]
EXPOSE 8090
