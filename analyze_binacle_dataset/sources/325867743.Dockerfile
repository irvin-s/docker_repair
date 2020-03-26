FROM funkey/gunpowder:v0.3
LABEL maintainer jfunke@iri.upc.edu

# install dependencies

RUN apt-get update && apt-get install -y --no-install-recommends \
        libmlpack-dev && \
    rm -rf /var/lib/apt/lists/*

# install mala

# assumes that mala package directory is in build context (the complementary
# Makefile ensures that)

WORKDIR /src
RUN git clone https://github.com/weihuang527/mala
WORKDIR /src/mala
RUN python setup.py install


WORKDIR /src
RUN git clone https://github.com/weihuang527/cremi
WORKDIR /src/cremi
RUN python setup.py install
