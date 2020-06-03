# DESCRIPTION:  Sphinx server
# AUTHOR:       Daniel Mizyrycki <mzdaniel@glidelink.net>
#
# COMMENTS:     Docker wrapper making sphinxserve pex docker installable.
#               This docker image (~110MB) contains a glibc linux pex (~9MB)
#               The image is only meant for building and transport. The python
#               pex file is Debian, Ubuntu, Centos and Arch compatible and is
#               based in the python package sphinxserve:
#                      https://pypi.python.org/pypi/sphinxserve
#               For docker runnable image (alpine based), use the equivalent
#               mzdaniel/sphinxserve (~40MB)
#
# Dependencies: Docker (only for downloading), python2.7 and a websocket
#               capable browser (Firefox, Chromium)
#
# TO INSTALL:   docker run mzdaniel/sphinxserve-pex > ~/bin/sphinxserve
#
# TO RUN:       ~/bin/sphinxserve [SPHINX_DOCS_PATH]
#
# TO BUILD:     docker build -t mzdaniel/sphinxserve-pex - < pex/Dockerfile
#
# HELP:         ~/bin/sphinxserve --help

FROM debian:7
MAINTAINER Daniel Mizyrycki mzdaniel@glidelink.net

ENV DEBIAN_FRONTEND noninteractive

# Build sphinxserve pex
RUN \
    mkdir /tmp/pkg /.pex && \
    chown 1000 /.pex && \
    apt-get update && \
    apt-get install -y --no-install-recommends python curl git \
        ca-certificates build-essential python-dev && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    pip install wheel pex && \
    pip wheel --wheel-dir=/tmp/pkg sphinxserve "gevent>=1.1b2" \
        "sphinx<1.3" "sphinx_rtd_theme<0.1.8" sphinx_bootstrap_theme \
        sphinxjp.themes.revealjs && \
    cd /tmp/pkg; pex -v --disable-cache --no-index -f . -c sphinxserve \
        -o /sphinxserve * && \
    sha1sum /sphinxserve | tee /sphinxserve.sha1 && \
    apt-get autoremove -y python python-dev curl git ca-certificates \
        build-essential && \
    rm -rf /var/cache/* /tmp/* /usr/lib/x86_64-linux-gnu /usr/share \
        /usr/lib/python2.7 /usr/local/lib/python2.7 /var/lib/apt \
        /var/lib/dpkg /root/.cache

ENTRYPOINT ["/bin/cat"]
CMD ["/sphinxserve"]
