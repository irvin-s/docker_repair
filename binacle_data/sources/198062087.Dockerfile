FROM jfactory/common-slave:latest
MAINTAINER Sławek Piotrowski <sentinel@atteo.com>

USER root

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && rm -rf /var/lib/apt/lists/* \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs bzip2 libfontconfig yarn && rm -rf /var/lib/apt/lists/*

USER jenkins
