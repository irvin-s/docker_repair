FROM mediawiki:1.31

COPY xlp_dev /tmp/xlp_dev
COPY xlp_init.sh /tmp/
COPY xlp_start.sh /tmp/

WORKDIR /tmp
RUN ["/bin/sh", "-c", "./xlp_init.sh"]

EXPOSE 80

CMD ["/bin/sh", "-c", "./xlp_start.sh"]
