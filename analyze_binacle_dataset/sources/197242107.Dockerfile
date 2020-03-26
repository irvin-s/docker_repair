# Set the python version here so that we can use it to set the base image.
ARG PYTHON_VERSION=2.7.15
# Docker file for the Overwatch base image
# We build from the python base image, which is based on Debian and contains many common and useful packages
FROM python:${PYTHON_VERSION}-stretch
LABEL maintainer="Raymond Ehlers <raymond.ehlers@cern.ch>, Yale University"

# Make the python version available in the container.
ARG PYTHON_VERSION

# Needed to ensure that krb5-user installs successfully
# See: https://stackoverflow.com/a/39805151
ENV DEBIAN_FRONTEND noninteractive
# Installed neede packages
# ROOT dependencies from https://root.cern.ch/build-prerequisites
#   - The required dependencies span from git to python
#   - Optional are python-dev and libssl-dev (although libssl-dev is needed for xrootd)
#     and python-dev is required for Overwatch
#   - We can't use gsl because the version is incompatible -> MathMore lib is disabled
#   - npm (via nodejs) is for bower
#   - python-pip is required for overwatch
#   - supervisor is required for running multiple programs in docker
#   - nginx is required to serve the webapp
#   - zmq is required for the overwatch HLT receiver.
#         NOTE: libzmqq3-dev is actually version 4 (ie up to date)...
#   - libkrb5-dev and krb5-user are for kerberos (XRootD needs it for auth)
#   - autossh for managing ssh connects for ZMQ receivers.
#   - rsync for installing the AliEn CAs (and for Overwatch data transfers).
# NOTE: Most of the dependencies are commented out because the python base image already
#       has these packages installed! We keep them so we don't have to sort them out again later
#       if the base image changes what is available.
# NOTE: Need to setup the nodejs source before getting updates. We will install version 10.
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y \
        #git \
        #dpkg-dev \
        cmake \
        #g++ \
        #gcc \
        #binutils \
        #libx11-dev \
        libxpm-dev \
        #libxft-dev \
        #libxext-dev \
        #libpng-dev \
        #libjpeg-dev \
        #libssl-dev \
        nodejs \
        nginx \
        libzmq3-dev \
        #libkrb5-dev \
        krb5-user \
        autossh \
        rsync \
    && rm -rf /var/lib/apt/lists/*
        # We delete the intermediate apt-get files once we are done

# Install supervisor.
# As of September 2018, the supervisor package on PyPI doesn't support python 3, so we take the master,
# which does (but perhaps has more bugs).
RUN /bin/bash -c 'if [[ "${PYTHON_VERSION}" == "2.7"* ]]; then pip install supervisor; else pip install git+https://github.com/Supervisor/supervisor.git#egg=supervisor; fi'

# Install required packages through npm.
# bower is required for isntalling polymer packages (should move to yarn eventually).
# polymer-bundler is for combining polymer packages into one file for efficiency.
# n allows updates of nodejs, which is needed for polymer-bundler.
# We intentionally run cache clean at the end to try to reclaim as much disk space as possible.
RUN npm install -g bower polymer-bundler n \
        && n lts \
        && npm cache clean --force

# nginx configuration.
# Explicitly configure nginx to run in the foreground and remove the default site. If we want to run it, we must run it explicitly.
RUN echo "daemon off;" >> /etc/nginx/nginx.conf && rm /etc/nginx/sites-enabled/default

# Setup a user so we don't have to run everything as root.
# Many packages expect root (or at least sudo to be available), so it takes a bit more care to get things
# setup properly. If absolutely required, one can switch back to the root user temporarily, but as of
# Oct 2018, this shouldn't be necessary for this Dockerfile.
# We also create the overwatch home directory since it makes installing things with python (and npm(?))
# much easier. uid of 2143 may not follow convention, but we need to select a uid which is unlikely to
# be used elsewhere, so we pick something far away from 500 and 1000, but not too large (which can
# apparently trigger a docker bug).
RUN groupadd -g 2143 overwatch \
        && useradd -r -u 2143 -g overwatch overwatch \
        && mkdir -p /home/overwatch \
        && chown -R overwatch:overwatch /home/overwatch

# Setup directory structure
ENV SCRATCH /opt/scratch
RUN mkdir -p ${SCRATCH} && chown -R overwatch:overwatch /opt

# Once we've installed the packages and setup the proper directories, root isn't needed. So switch to a
# less privileged user. Furthermore, we actually want to build and install as many packages as possible
# as the less privileged user to ensure that this user can access the files. If built as root, the file
# permissions may not be correct, which would require a chmod. chmod on many files will increase the docker
# image size substantially, so it's best to avoid this if possible.
USER overwatch

# Provide build scripts
COPY --chown=overwatch:overwatch buildScripts/*.sh ${SCRATCH}/buildScripts/

# Install XRootD
RUN mkdir -p ${SCRATCH}/xrootd && cd ${SCRATCH}/xrootd \
        && chmod +x ${SCRATCH}/buildScripts/buildXRootD.sh \
        && git clone https://github.com/xrootd/xrootd.git . \
        && git checkout tags/v4.8.4 \
        && mkdir build && cd build \
        && ${SCRATCH}/buildScripts/buildXRootD.sh ../ /opt/xrootd \
        && make -j2 install \
        && rm -r ${SCRATCH}/xrootd
# Remove src and build files to keep container size down (since we can't cache the build process
# to speed up later compilation). Someday docker might support such a volume build cache which
# would make this split into two docker files particularly useful

# Setup environment variables for the build type.
# We set it here because we only care about the build type for ROOT (not XRootD).
# For development, it would probably be best to be "RelWithDebInfo"
ARG ROOT_CMAKE_BUILD_TYPE
ENV CMAKE_BUILD_TYPE ${ROOT_CMAKE_BUILD_TYPE:-"RELEASE"}

# Install ROOT
RUN mkdir -p ${SCRATCH}/root && cd ${SCRATCH}/root \
        && chmod +x ${SCRATCH}/buildScripts/buildRoot.sh \
        && git clone --depth 1 --branch v6-14-06 https://github.com/root-project/root.git src \
        && mkdir build && cd build \
        && ${SCRATCH}/buildScripts/buildRoot.sh ../src /opt/root \
        && make -j2 install \
        && rm -r ${SCRATCH}/root
# Remove src and build files to keep container size down (since we can't cache the build process
# to speed up later compilation). Someday docker might support such a volume build cache which
# would make this split into two docker files particularly useful

# AliEn Certs needed for EOS
# The certs are not a dependency until runtime, so we can install it after XRootD and ROOT.
# We install them last because they are mostly likely to need the update (and we would like to
# avoid rebuilding the above)
RUN mkdir -p /opt/scratch/alienCAs && cd /opt/scratch/alienCAs \
        && git clone https://github.com/alisw/alien-cas.git . \
        && /opt/scratch/buildScripts/buildAlienCAs.sh /opt/scratch/alienCAs /opt/alienCAs \
        && rm -r /opt/scratch/alienCAs
# Remove src and build files to keep container size down (since we can't cache the build process
# to speed up later compilation). Someday docker might support such a volume build cache which
# would make this split into two docker files particularly useful

# Nothing further is configured here since this is just a base image!
CMD ["/bin/bash"]
