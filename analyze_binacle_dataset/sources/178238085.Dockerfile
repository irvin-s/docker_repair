FROM thelounge/thelounge:3.0.1-alpine
LABEL maintainer="Odd E. Ebbesen <oddebb@gmail.com>"

RUN apk add --no-cache --update tini \
		&& rm -rf /var/cache/apk/*

# Override entrypoint to get tini in the mix
ENTRYPOINT ["tini", "-g", "--", "docker-entrypoint.sh"]
CMD ["thelounge", "start"]

# Themes are installed in $THELOUNGE_HOME, so I'll add them
# to the bind mounted dir instead of including them in the image.

# Run unprivileged.
# User "node" aready exists from parent image, with uid:gid 1000:1000
USER node
