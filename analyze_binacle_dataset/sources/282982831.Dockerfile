FROM alpine:3.9
LABEL maintainer="Gianluca Boiano <morf3089@gmail.com>"

COPY resources /
RUN /docker-entrypoint.sh

# Expose raspberry ssh port mapped on 2222 by qemu
EXPOSE 2222
CMD ["simonpi", "-h"]
