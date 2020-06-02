FROM debian:jessie

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y libmozjs-24-bin libjson-perl curl wget \
	&& rm -rf /var/lib/apt/lists/*

# we need jsawk to fiddle with the config file
RUN curl -Ls https://github.com/micha/jsawk/raw/5a14c4af3c7b59807701b70a954ecefc6f77e978/jsawk >/usr/local/bin/jsawk \
	&& curl -Ls https://raw.githubusercontent.com/micha/resty/4d1b8bed5a9dd5173668e670c759dea25647a896/pp >/usr/local/bin/pp \
	&& chmod +x /usr/local/bin/jsawk /usr/local/bin/pp \
	&& sed -i 's#JSBIN=.*#JSBIN=/usr/bin/js24#' /usr/local/bin/jsawk \
	&& ( echo '{}' | jsawk 'this.test = true;' | grep 'test' ) \
	&& ( echo '{"test": 1}' | pp )

WORKDIR /mattermost
VOLUME /data

RUN wget https://github.com/mattermost/platform/releases/download/v0.7.1/mattermost.tar.gz -O /tmp/mattermost.tar.gz \
	&& cd /mattermost \
	&& tar -zxvf /tmp/mattermost.tar.gz --strip-components=1 \
	&& rm /tmp/mattermost.tar.gz

RUN adduser --home /mattermost --no-create-home --ingroup daemon --shell /bin/false --system mattermost

RUN rm -rf /mattermost/logs \
	&& ln -svf /data/logs /mattermost/logs

ADD config.default.json /mattermost/
ADD entrypoint.sh /
ADD mattermost /usr/local/bin/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mattermost"]

EXPOSE 8080
