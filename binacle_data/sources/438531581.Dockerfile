ARG TAG
FROM vbatts/slackware:${TAG}

ENV WHEELHOUSE_PATH /tmp/wheelhouse
ENV VIRTUALENV_PATH /tmp/venv
# This will get updated by the CircleCI checkout step.
ENV BUILD_SRC_ROOT /tmp/project

# Be careful with slackpkg.  If the package name given doesn't match anything,
# slackpkg still claims to succeed but you're totally screwed.  Slackware
# updates versions of packaged software so including too much version prefix
# is a good way to have your install commands suddenly begin not installing
# anything.
RUN slackpkg update && \
    slackpkg install \
        openssh-7 git-2 \
        ca-certificates \
        sudo-1 \
        make-4 \
        automake-1 \
        kernel-headers \
        glibc-2 \
        binutils-2 \
        gcc-5 \
        gcc-g++-5 \
        python-2 \
        libffi-3 \
        libyaml-0 \
        sqlite-3 \
        icu4c-56 \
        libmpc-1 </dev/null && \
    slackpkg upgrade \
        openssl-1 </dev/null

# neither virtualenv nor pip is packaged.
# do it the hard way.
# and it is extra hard since it is slackware.
RUN slackpkg install \
        cyrus-sasl-2 \
        curl-7 </dev/null && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install virtualenv

# Get the project source.  This is better than it seems.  CircleCI will
# *update* this checkout on each job run, saving us more time per-job.
COPY . ${BUILD_SRC_ROOT}

RUN "${BUILD_SRC_ROOT}"/.circleci/prepare-image.sh "${WHEELHOUSE_PATH}" "${VIRTUALENV_PATH}" "${BUILD_SRC_ROOT}"
