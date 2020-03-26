FROM debian:stretch

ENV GOTRACEBACK crash

RUN apt-get update && apt-get install -y --no-install-recommends \
		gdb \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /sources/crashdump

EXPOSE 8080

CMD ["./crashdump"]