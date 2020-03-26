# This file creates a container that runs a Caliopen CLI tool for machine learning tasks
# Important:
# Author: Caliopen
# Date: 2018-07-20

FROM public-registry.caliopen.org/caliopen_python
MAINTAINER Caliopen

RUN apk add git

# Add local backend source directory in container filesystem
COPY . /srv/caliopen/src/backend

# Install external packages
RUN pip install git+https://github.com/facebookresearch/fastText.git

# Download nltk data
RUN mkdir -p /usr/share/nltk_data/tokenizers
WORKDIR /usr/share/nltk_data/tokenizers
RUN wget -O punkt.zip https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/tokenizers/punkt.zip
RUN unzip punkt.zip


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
WORKDIR /srv/caliopen/src/backend/components/py.data
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/components/py.tag
RUN pip install -e .
WORKDIR /srv/caliopen/src/backend/tools/py.CLI
RUN pip install -e .

## Container specific installation part
WORKDIR /srv/caliopen/src/backend/tools/py.ML
RUN pip install -e .
RUN pip install ipython

WORKDIR /srv/caliopen/src/backend
ENTRYPOINT ["caliopml", "--config", "/etc/caliopen/caliopen.yaml"]
