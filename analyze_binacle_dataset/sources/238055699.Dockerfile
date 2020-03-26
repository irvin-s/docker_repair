FROM ubuntu:xenial

RUN apt-get update ; apt-get install -y curl jq python-twisted python-twisted-web \
    python-dev python-setuptools g++ swig libjson0 libjson0-dev libcrypto++-dev \
    git python-all-dev python-stdeb
# http://intelledger.github.io/0.8/sysadmin_guide/packaging_ubuntu.html
RUN apt-get install -y wget
RUN mkdir $HOME/packages ; mkdir $HOME/projects
RUN cd $HOME/projects && wget https://pypi.python.org/packages/source/c/cbor/cbor-0.1.24.tar.gz && \
    tar xvfz cbor-0.1.24.tar.gz && cd cbor-0.1.24 && \
    python setup.py --command-packages=stdeb.command bdist_deb && \
    cp deb_dist/python-cbor*.deb $HOME/packages/
#
RUN cd $HOME/projects && wget https://pypi.python.org/packages/source/c/colorlog/colorlog-2.6.0.tar.gz && \
    tar xvfz colorlog-2.6.0.tar.gz && cd colorlog-2.6.0 && \
    python setup.py --command-packages=stdeb.command bdist_deb && \
    cp deb_dist/python-colorlog*.deb $HOME/packages/
#
RUN cd $HOME/projects && wget https://pypi.python.org/packages/source/p/pybitcointools/pybitcointools-1.1.15.tar.gz && \
    tar xvfz pybitcointools-1.1.15.tar.gz && cd pybitcointools-1.1.15 && \
    python setup.py --command-packages=stdeb.command bdist_deb && \
    cp deb_dist/python-pybitcointools*.deb $HOME/packages/
#
RUN cd $HOME/projects && git clone --depth=1 https://github.com/hyperledger/sawtooth-core.git && \
    cd $HOME/projects/sawtooth-core/core && \
    python setup.py --command-packages=stdeb.command bdist_deb && \
    cp deb_dist/python-sawtooth-core*.deb $HOME/packages/

# https://github.com/hyperledger/sawtooth-core/archive/v0.8.0.tar.gz
