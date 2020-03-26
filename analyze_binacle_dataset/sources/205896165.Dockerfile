FROM python:3.5-alpine
MAINTAINER Stuart Davidson <stuart.davidson@skyscanner.net>

ENV \
    BUILD_DEPS="curl bash git"

RUN mkdir -p -m 777 /opt/test

RUN \
    # Install Build Dependencies
    apk add --update ${BUILD_DEPS} 

RUN \	
	# Install Bats
	git clone https://github.com/sstephenson/bats.git \
	&& cd bats \
	&& ./install.sh /opt/test/bats \
	&& ln -s /opt/test/bats/bin/bats /usr/bin/bats
		
# To set-up test
ADD include /opt/test/
RUN chmod -R 777 /opt/test

USER nobody
WORKDIR /opt/test

ENTRYPOINT ["bash", "/opt/test/test.sh"]