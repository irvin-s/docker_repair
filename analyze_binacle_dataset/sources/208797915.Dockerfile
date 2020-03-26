FROM debian:jessie

MAINTAINER Matthew Tonkin - Dunn <mattythebatty@gmail.com>

RUN apt-get update && \
    apt-get -y install curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/bin/wp && \
	chmod +x /usr/bin/wp

ENTRYPOINT ["wp"]
CMD ["--info"]
