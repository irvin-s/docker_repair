FROM fellah/gitbook

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

RUN apt-get update && \
	apt-get install -y calibre && \
	apt-get clean && \
	rm -rf /tmp/* /var/lib/{apt,dpkg,cache,log}/*

CMD /usr/local/bin/gitbook serve
