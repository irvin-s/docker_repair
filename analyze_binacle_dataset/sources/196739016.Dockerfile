FROM python:2.7-slim
LABEL maintainer="ops@opentargets.org"

#need make gcc etc for requirements later
#need git to pip install from git
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    automake \
    pkg-config \
    python-dev \
    libtool 

# Build PyFlame
RUN git clone https://github.com/uber/pyflame.git && cd pyflame && ./autogen.sh && ./configure && make
# Install flamegraph to turn pyflame output into pretty picture
RUN git clone https://github.com/brendangregg/FlameGraph

#needed for pgrep
RUN apt-get update && apt-get install -y \
    procps

# install fresh these requirements.
# do this before copying the code to minimize image layer rebuild for dev
COPY ./requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

#put the application in the right place
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN pip install --no-cache-dir -e .

# point to the entrypoint script fo pyflame
ENTRYPOINT [ "scripts/entrypoint.pyflame.sh" ]