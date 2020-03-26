FROM alpine

# NOTE: exec './build.sh' locally before attempting to build this Docker image

ADD ./bin/udocs /bin/udocs

EXPOSE 9554

ENTRYPOINT udocs serve --headless
