FROM buildpack-deps:jessie-curl

RUN apt-get update \
	&& apt-get install -y unzip libelf1 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& curl -SL "https://github.com/facebook/flow/releases/download/v0.9.2/flow-linux64-v0.9.2.zip" -o "flow-linux64-v0.9.2.zip" \
	&& unzip "flow-linux64-v0.9.2.zip" -d /usr/local \
	&& rm "flow-linux64-v0.9.2.zip"


ENV PATH /usr/local/flow:$PATH

VOLUME /app
WORKDIR /app

CMD ["flow", "check"]