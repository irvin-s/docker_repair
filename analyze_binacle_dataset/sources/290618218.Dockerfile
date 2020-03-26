FROM node:8
# replace this with your application's default port
EXPOSE 8080

RUN mkdir -p /usr/src/mappr
WORKDIR /usr/src/mappr

####################
#### Install Ruby(Copied from official ruby dockerfile) ####
####################
ENV RUBY_MAJOR 2.4
ENV RUBY_VERSION 2.4.3
ENV RUBY_DOWNLOAD_SHA256 23677d40bf3b7621ba64593c978df40b1e026d8653c74a0599f0ead78ed92b51
ENV RUBYGEMS_VERSION 2.7.4
ENV BUNDLER_VERSION 1.16.1

RUN set -ex \
	\
	&& buildDeps=' \
		bison \
		dpkg-dev \
		libgdbm-dev \
		ruby \
	' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& rm -rf /var/lib/apt/lists/* \
	\
	&& wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum -c - \
	\
	&& mkdir -p /usr/src/ruby \
	&& tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.xz \
	\
	&& cd /usr/src/ruby \
	\
# hack in "ENABLE_PATH_CHECK" disabling to suppress:
#   warning: Insecure world writable dir
	&& { \
		echo '#define ENABLE_PATH_CHECK 0'; \
		echo; \
		cat file.c; \
	} > file.c.new \
	&& mv file.c.new file.c \
	\
	&& autoconf \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
		--build="$gnuArch" \
		--disable-install-doc \
		--enable-shared \
	&& make -j "$(nproc)" \
	&& make install \
	\
	&& apt-get purge -y --auto-remove $buildDeps \
	&& cd / \
	&& rm -r /usr/src/ruby \
	\
	&& gem update --system "$RUBYGEMS_VERSION" \
	&& gem install bundler --version "$BUNDLER_VERSION" --force
# Install Ruby end

RUN gem install sass && gem install compass

COPY package.json /usr/src/mappr/
RUN npm install && npm install --only=dev && npm cache --force clean

COPY .bowerrc /usr/src/mappr/
COPY bower.json /usr/src/mappr/
RUN echo '{ "allow_root": true }' > /root/.bowerrc && \
	npm install -g bower && bower install

COPY client /usr/src/mappr/client
COPY etl-scripts /usr/src/mappr/etl-scripts
COPY server /usr/src/mappr/server
COPY test /usr/src/mappr/test
COPY mapping.json /usr/src/mappr/
COPY *.js /usr/src/mappr/
COPY *.sh /usr/src/mappr/


RUN npm install -g grunt-cli
RUN grunt

RUN chmod +x ./run_docker_mode.sh && \
	chmod +x ./wait-for-it.sh

ENV NODE_ENV "docker"

CMD [ "npm", "start" ]
