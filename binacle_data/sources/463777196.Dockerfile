FROM python:3.7

WORKDIR /opt/fairing
ARG CLOUD_SDK_VERSION="236.0.0"

# Install pinned version of gcloud
RUN mkdir -p /builder && \
	wget -qO- https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz | tar zx -C /builder && \
	CLOUDSDK_PYTHON="python3.5" /builder/google-cloud-sdk/install.sh --usage-reporting=false \
		--bash-completion=false \
		--disable-installation-options && \
	rm -rf ~/.config/gcloud

ENV PATH=/builder/google-cloud-sdk/bin/:$PATH

# Install test dependencies
RUN pip install pytest pytest-cov pytest-xdist papermill
# TODO: Find a better to run e2e tests without
# adding a lot of reqs
COPY examples/prediction/requirements.txt  examples/prediction/requirements.txt 
RUN pip install -r examples/prediction/requirements.txt

# Install dependencies
COPY setup.py requirements.txt /opt/fairing/
RUN pip install -e .

# Install Fairing
COPY . /opt/fairing
RUN python setup.py install

ENTRYPOINT pytest
