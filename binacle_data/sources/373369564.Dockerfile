ARG LINOTP_BASE_IMAGE
FROM $LINOTP_BASE_IMAGE

ARG DEBIAN_MIRROR=deb.debian.org

ENV LINOTP_HOST=test-linotp \
	LINOTP_PORT=443 \
	LINOTP_PROTOCOL=https \
	LINOTP_USERNAME=admin \
	LINOTP_PASSWORD=admin \
	SELENIUM_DRIVER=chrome \
	SELENIUM_PROTOCOL=http \
	SELENIUM_HOST=test-chrome \
	SELENIUM_PORT=4444 \
	TEST_BUNCH=integrationtests

# Copy e2e/integration test scripts and test data in the image
# Here the deb packages for the admin client are provided in the
# tests/apt directory (after copy statement below has run)
COPY . /opt/linotp/tests
WORKDIR /opt/linotp/tests

# In ./apt you have provided the linotp and admin client debs
# LinOTP is already installed, but we need the admin client
# for some of the e2e tests

RUN echo "deb [trusted=yes] file:/opt/linotp/tests/apt ./" > /etc/apt/sources.list.d/linotp-local.list

RUN apt-get update && apt-get install -y \
  		make \
  		python-nose-testconfig \
  		linotp-adminclient-cli

# Get latest pip
RUN apt-get install curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip --version
RUN python -m pip install --upgrade pip
RUN pip --version

RUN pip freeze
RUN pip install wheel
RUN pip install packaging
RUN pip install selenium
RUN pip install flaky
RUN pip install pysocks
RUN pip freeze


ENTRYPOINT [ \
		"/usr/local/bin/dockerfy", \
			"--template", "docker_cfg.ini.tmpl:server_cfg.ini", \
			"--wait", "tcp://{{ .Env.SELENIUM_HOST }}:{{ .Env.SELENIUM_PORT }}", "--timeout", "60s", \
			"--wait", "tcp://{{ .Env.LINOTP_HOST }}:{{ .Env.LINOTP_PORT }}", "--timeout", "60s", \
		    "--" \
	]

CMD /usr/bin/make $TEST_BUNCH
