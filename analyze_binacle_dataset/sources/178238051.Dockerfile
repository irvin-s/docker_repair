FROM eggdrop:latest
LABEL maintainer="Odd E. Ebbesen <oddebb@gmail.com>"

RUN apk add --no-cache tini shadow && \
		rm -rf /var/cache/apk/*

RUN usermod -u 1000 eggdrop

ENTRYPOINT ["tini", "-g", "--", "/home/eggdrop/eggdrop/entrypoint.sh"]
CMD ["eggdrop.conf"]
