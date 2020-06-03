FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
		apache2-utils \
		gcc \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app
COPY ./rea /app

EXPOSE 80

CMD ["/app/rea", "80"]
