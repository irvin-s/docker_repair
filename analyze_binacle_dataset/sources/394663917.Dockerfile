FROM google/python

RUN    apt-get update \
	&& apt-get install -y --no-install-recommends mercurial libjpeg-dev libpng-dev libpqxx3-dev libmysqlclient-dev \
	&& apt-get clean \
	&& rm -rf /var/cache/apt/*

VOLUME  ["/data", "/env", "/code"]

ADD run.sh /run.sh

EXPOSE 5000

CMD ["/run.sh"]
