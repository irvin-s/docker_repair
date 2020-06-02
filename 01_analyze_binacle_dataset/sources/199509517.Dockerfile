# This file creates a container that runs a Caliopen CLI tool
# Important:
# Author: Caliopen
# Date: 2018-07-20

FROM public-registry.caliopen.org/caliopen_python
MAINTAINER Caliopen

# Add local backend source directory in container filesystem
COPY . /srv/caliopen/src/backend

# Install Caliopen base packages
WORKDIR /srv/caliopen/src/backend/main/py.storage
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/components/py.pgp
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/components/py.pi
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/main/py.main
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/interfaces/NATS/py.client
RUN pip install -e .

## Container specific installation part
WORKDIR /srv/caliopen/src/backend/tools/py.CLI
RUN pip install -e .
RUN pip install ipython

WORKDIR /srv/caliopen/src/backend
ENTRYPOINT ["caliopen", "-f", "/etc/caliopen/caliopen.yaml"]
