FROM heroku/cedar:14

RUN mkdir /app
RUN addgroup --quiet --gid 2000 slug && \
    useradd slug --uid=2000 --gid=2000 --home-dir /app --no-create-home \
        --shell /bin/bash

WORKDIR /app

# add default port to expose (can be overridden)
ENV PORT 5000
EXPOSE 5000

ADD ./runner /runner
ADD ./bin /bin
ADD https://storage.googleapis.com/object-storage-cli/bb8e054/objstorage-bb8e054-linux-amd64 /bin/objstorage
RUN chmod +x /bin/objstorage && \
    chown slug:slug /app \
                    /runner/init \
                    /bin/get_object \
                    /bin/objstorage

USER slug
ENV HOME /app
ENTRYPOINT ["/runner/init"]

ONBUILD RUN mkdir -p /app
ONBUILD WORKDIR /app
ONBUILD ADD slug.tgz /app
