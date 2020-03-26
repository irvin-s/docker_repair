FROM python:2.7

ENV DEBIAN_FRONTEND=noninteractive

# update/upgrade apt-get
RUN apt-get -yq update \
	&& apt-get -yq upgrade

# install apt-get apps
RUN apt-get install -y pylint

# clean up after apt-get
RUN apt-get -y autoremove \
	&& apt-get -y -q clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/* \
	&& rm -rf /var/tmp/*

# install python packages
RUN pip install --upgrade pip \
	&& pip install google-api-python-client pyyaml

WORKDIR /usr/src

CMD [ "/bin/bash" ]
