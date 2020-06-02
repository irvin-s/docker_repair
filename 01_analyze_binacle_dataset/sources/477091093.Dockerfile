#-------BUILD javascript task presenter in dist/ -----------------
FROM python:2.7.13-slim as builder
# Prep base
RUN apt-get update -q
WORKDIR /bd_build
COPY /docker/bd_build /bd_build
RUN ./prepare.sh

ENV PYTHONIOENCODING UTF-8
ENV TERM xterm
# ARG vars exist only during build and can be overridden by --build-args
ARG DEBIAN_FRONTEND=noninteractive
ARG MINIMAL_APT_INSTALL="apt-get install -q -y --no-install-recommends"

RUN $MINIMAL_APT_INSTALL \
        curl \
        python

WORKDIR /home/download
ARG NODEREPO="node_6.x"
ARG DISTRO="jessie"
# Only newest package kept in nodesource repo. Cannot pin to version using apt!
# See https://github.com/nodesource/distributions/issues/33
#RUN curl -sSO https://deb.nodesource.com/gpgkey/nodesource.gpg.key
#RUN apt-key add nodesource.gpg.key
#RUN echo "deb https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list
#RUN echo "deb-src https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list
#RUN apt-get update -q && apt-get install -q -y 'nodejs=6.11.3*'

# So we have to download specific package in order to pin version of node.
# dpkg doesn't install package dependencies automatically, we have to do it.
# This nodejs package has a dependency on the 'python' package, installed above.
# Since this is a python:2.7-slim image, you would think python packages
# are installed. But the Dockerfile installs Python from source, not packages.

# jessie specific version not provided starting with 6.11.3
#ARG NODE_PACKAGE=nodejs_6.11.2-1nodesource1~jessie1_amd64.deb
ARG NODE_PACKAGE=nodejs_6.11.3-1nodesource1_amd64.deb
RUN curl -sSO "https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/${NODE_PACKAGE}"
RUN dpkg -i ${NODE_PACKAGE}

RUN curl -sSO https://dl.yarnpkg.com/debian/pubkey.gpg
RUN apt-key add pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -q && $MINIMAL_APT_INSTALL 'yarn=1.0.2*'

# note: Development config mounts the git repo root on this path.
# Copy minimal files needed to npm install to try
# and re-use cache
ENV WEBPACK_BUILD_DIR /home/thresher
WORKDIR /home/thresher
RUN chown ${USER}:${USER} /home/thresher
COPY /package.json /home/thresher
COPY /yarn.lock /home/thresher

USER ${USER}
RUN yarn install

# Now copy the rest of the repo into the image - any file change breaks build cache
# .dockerignore must exclude node_modules/ and dist/
COPY /.babelrc .
COPY /app ./app
COPY /webpack ./webpack
COPY /webpack.config.js .
RUN npm run deploy:quiet

#-------IMAGE FOR BOTH DJANGO SERVER & PYTHON RQ SERVICE----------------
FROM python:2.7.13-slim as django
USER root

# Prep base
RUN apt-get update -q
WORKDIR /bd_build
COPY /docker/bd_build /bd_build
RUN ./prepare.sh

ENV PYTHONUNBUFFERED 1
ENV PYTHONIOENCODING UTF-8
ENV TERM xterm
# ARG vars exist only during build and can be overridden by --build-args
ARG DEBIAN_FRONTEND=noninteractive
ARG MINIMAL_APT_INSTALL="apt-get install -q -y --no-install-recommends"

RUN $MINIMAL_APT_INSTALL \
        curl \
        gcc \
        gettext \
        postgresql-client libpq-dev \
        vim less psmisc

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /home/build
COPY /docker/thresher_api/requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# ipython for development - not (currently) needed for production
RUN pip install ipython

ARG USER=thresher
ARG USER_ID=9000
ARG GROUP_ID=9000
ARG HOME=/home/thresher
RUN groupadd -g ${GROUP_ID} ${USER} && \
      useradd --shell /bin/bash --home ${HOME} -u ${USER_ID} -g ${GROUP_ID} ${USER}

# Let Django copy to static dir as regular user
WORKDIR /var/www
RUN chown ${USER}:${USER} /var/www

ENV PYTHONPATH /home/thresher
WORKDIR /home/thresher
RUN chown ${USER}:${USER} /home/thresher
COPY --from=builder /home/thresher/dist ./dist
COPY /data ./data
COPY /docker ./docker
COPY /manage.py .
COPY /researcher ./researcher
COPY /thresher ./thresher
COPY /thresher_backend ./thresher_backend

# helpful aliases
COPY /docker/bashrc_to_docker /root/.bashrc
COPY /docker/bashrc_to_docker ${HOME}/.bashrc
EXPOSE 5000

USER ${USER}
# Runs migrate, then replaces sh with 'exec gunicorn...'
CMD ["bash", "docker/thresher_api/migrate_and_run.sh"]
