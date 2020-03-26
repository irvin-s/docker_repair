# https://hub.docker.com/_/python/
FROM buildpack-deps:jessie

# To build:
# docker build -t partycrasher .

# To run:
# docker run -it --rm --name partycrasher partycrasher

# PartyCrasher will be exposed on port 5000

MAINTAINER Eddie Antonio Santos <easantos@ualberta.ca>

EXPOSE 5000

# === Copied from ===
# https://github.com/docker-library/python/blob/9383f7d4d2f96068e8957651aa3588fee8b48f71/2.7/Dockerfile
# https://github.com/docker-library/python/blob/7663560df7547e69d13b1b548675502f4e0917d1/2.7/onbuild/Dockerfile

# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks
# Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PYTHON_VERSION 2.7.11

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 8.1.2

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
ENV GPG_KEY C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install Python
RUN set -ex \
    && curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
    && curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
    && gpg --batch --verify python.tar.xz.asc python.tar.xz \
    && rm -r "$GNUPGHOME" python.tar.xz.asc \
    && mkdir -p /usr/src/python \
    && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
    && rm python.tar.xz \
    \
    && cd /usr/src/python \
    && ./configure --enable-shared --enable-unicode=ucs4 \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
    && pip install --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION \
    && find /usr/local -depth \
        \( \
            \( -type d -a -name test -o -name tests \) \
            -o \
            \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        \) -exec rm -rf '{}' + \
    && rm -rf /usr/src/python ~/.cache

# Install Node, Bower
RUN curl -fsL https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g bower

# Install the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

# Install deps
RUN cd /usr/src/app/partycrasher/ngapp && \
    bower --allow-root --force-latest install

### Finally, the main command:
CMD [ "python", "partycrasher/rest_service.py", "--port", "5000" ]
