# Build portion
# Set the python version here so that we can use it to set the base image. Default to python 2.
ARG PYTHON_VERSION=2.7.15
FROM rehlers/overwatch-base:py${PYTHON_VERSION}
LABEL maintainer="Raymond Ehlers <raymond.ehlers@cern.ch>, Yale University"

# Make the python version available in the container.
ARG PYTHON_VERSION

# Allow Overwatch branch to be set from the args.
# Used to checkout the proper branch when building on travis. For example, if branch "test-docker" is built
# on travis, then we want it to build the latest docker image using that branch.
# Defaults to master when used below if not specified.
ARG OVERWATCH_BRANCH="master"

# Setup ENV for XRootD, Root, etc
ENV XROOTDSYS="/opt/xrootd"
ENV ROOTSYS="/opt/root"
# Setup PATH for XRootD, ROOT, and python (pip installed via --user)
ENV PATH="${XROOTDSYS}/bin:${ROOTSYS}/bin:/home/overwatch/.local/bin:${PATH}"
ENV LD_LIBRARY_PATH="${XROOTDSYS}/lib:${ROOTSYS}/lib:${LD_LIBRARY_PATH}"
# Need the python x.y version (eg `2.7`) to determine the path to the site packages.
# We need to extract it this way because docker supports limited parameter extraction.
RUN PYTHON_VERSION_X_Y=$(python -c "import sys; print('{}.{}'.format(sys.version_info.major, sys.version_info.minor))")
ENV PYTHONPATH="${ROOTSYS}/lib:${XROOTDSYS}/lib/python${PYTHON_VERSION_X_Y}/site-packages/:${PYTHONPATH}"
# Make the AliEn CAs availble for connecting to the grid.
ENV X509_CERT_DIR="/opt/alienCAs"

# If we were using multi-stage builds, this would be where we would copy the installed software.
# However, travis tries to rebuild everything in this Dockerfile, so we need to minimize the build
# steps here. This means that multi-stage builds don't make sense right now.
# Copy the /opt directory from the build container which contains AliEn CAs, XRootD, and Root.
#COPY --from=rehlers/overwatch-base:latest-${PYTHON_VERSION} /opt /opt

# Setup OVERWATCH
ENV OVERWATCH_ROOT /opt/overwatch
# We intentionally make the directory before setting it as the workdir so the directory is made with user permissions
# (workdir always creates the directory with root permissions)
RUN mkdir -p ${OVERWATCH_ROOT}
WORKDIR ${OVERWATCH_ROOT}
# Download OVERWATCH, setup the needed python packages, and compile the reciever
# Size increase here is mainly due to the numpy dependency. We use --no-cache-dir to keep the image size down.
# NOTE: Temporarily pinned pip to 18.1 because of a bug in 19.0. See: https://github.com/pypa/pip/issues/6197
RUN git clone https://github.com/raymondEhlers/OVERWATCH.git . \
        && git checkout origin/${OVERWATCH_BRANCH} \
        && pip install --user --no-cache-dir --upgrade pip==18.1 \
        && pip install --user --no-cache-dir git+https://github.com/SpotlightKid/flask-zodb.git \
        && pip install --user --no-cache-dir -e ".[tests, docs, dev]" \
        && mkdir -p receiver/build && cd receiver/build \
        && cmake "../" -DCMAKE_INSTALL_PREFIX="/opt/receiver" -DZEROMQ="/usr" \
        && make install
# Add receiver to path
ENV PATH="/opt/receiver/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/receiver/lib:${LD_LIBRARY_PATH}"

# Install Polymer, webcomponents using bower, and install jsRoot by hand.
# npm, bower, and n were already setup in the base image.
RUN cd overwatch/webApp/static \
        && bower install \
        && cd /tmp && git clone https://github.com/root-project/jsroot.git \
        && mkdir -p ${OVERWATCH_ROOT}/overwatch/webApp/static/jsRoot/ \
        && cp -r jsroot/scripts ${OVERWATCH_ROOT}/overwatch/webApp/static/jsRoot/. && cp -r jsroot/style ${OVERWATCH_ROOT}/overwatch/webApp/static/jsRoot/. \
        && rm -r /tmp/jsroot

# Configure supervisord
# This launches overwatchDeploy, which will then update the supervisor config.
COPY --chown=overwatch:overwatch supervisord.conf ${OVERWATCH_ROOT}

# Everything is run behind supervisor
CMD ["/usr/local/bin/supervisord"]

