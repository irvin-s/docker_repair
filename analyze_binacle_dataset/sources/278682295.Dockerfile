FROM quay.io/pypa/manylinux1_x86_64

ENV OPENSSL_VERSION="1.0.2l"
ENV LIBFFI_VERSION="3.2.1"
ENV LIBXML_VERSION="2.9.2"
ENV LIBXSLT_VERSION="1.1.29"

# Required environment variables to be set at runtime:
#   - INCLUDE: space separated list of files/folders relative to the working dir
#     to include in the build lambda_function.zip
#   - EXTRA_PACKAGES: space separated list ofextra rpm packages to install from
#     official rpm repos
#   - VERSION_HASH: build version (sha1, etc.) of the code
#   - BUILD_TIME: timestamp of the in-progress build

# Mounts to include:
#   - /dependencies/requirements.txt  WAT
#   - /src: root of the src/repo to pull in for the build
#   - /dist: contains the output lambda_function.zip

# Make sure /dependencies/requirements.txt is a file!
# See https://docs.docker.com/storage/bind-mounts/#differences-between--v-and---mount-behavior.
RUN mkdir /dependencies
RUN touch /dependencies/requirements.txt

ENV CFLAGS="-I/openssl/include -I/libffi/lib/libffi-${LIBFFI_VERSION}/include"
ENV LDFLAGS="-L/openssl/lib -L/libffi/lib64"
ENV LD_LIBRARY_PATH="/libffi/lib64"

# Directory for built wheels
RUN mkdir /build_cache
# Directory for installed wheels, to be included in final zip
RUN mkdir /install

# Some commonly used dependencies (cryptography, lxml, etc.) require newer
# versions of certain libraries that aren't available for CentOS 5, which is
# the base distro of the Docker image used for building Python packages. Let's
# install these from source, when requested.
RUN yum install -y libtool texinfo zip

# Symlink all the existing autoconf macros into the installed tool's directory

RUN for MACRO in `ls /usr/share/aclocal`; do ln -s /usr/share/aclocal/${MACRO} /usr/local/share/aclocal/${MACRO} ; done

# Build source libxml2 and libxslt RPMs
RUN yum install -y rpm-build python-devel libgcrypt-devel xz-devel zlib-devel && \
    curl -O http://xmlsoft.org/sources/libxml2-${LIBXML_VERSION}-1.fc19.src.rpm && \
    rpm -ivh libxml2-${LIBXML_VERSION}-1.fc19.src.rpm --nomd5 && \
    rpmbuild -ba /usr/src/redhat/SPECS/libxml2.spec && \
    rpm -ivh --force /usr/src/redhat/RPMS/x86_64/libxml2-${LIBXML_VERSION}-1.x86_64.rpm && \
    rpm -ivh --force /usr/src/redhat/RPMS/x86_64/libxml2-devel-${LIBXML_VERSION}-1.x86_64.rpm && \
    rpm -ivh --force /usr/src/redhat/RPMS/x86_64/libxml2-python-${LIBXML_VERSION}-1.x86_64.rpm && \
    curl -O http://xmlsoft.org/sources/libxslt-${LIBXSLT_VERSION}-1.fc23.src.rpm && \
    rpm -ivh libxslt-${LIBXSLT_VERSION}-1.fc23.src.rpm --nomd5 && \
    rpmbuild -ba /usr/src/redhat/SPECS/libxslt.spec && \
    rpm -ivh --force /usr/src/redhat/RPMS/x86_64/libxslt-${LIBXSLT_VERSION}-1.x86_64.rpm && \
    rpm -ivh --force /usr/src/redhat/RPMS/x86_64/libxslt-devel-${LIBXSLT_VERSION}-1.x86_64.rpm

# Build OpenSSL from source
RUN curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz && \
    tar xf openssl-${OPENSSL_VERSION}.tar.gz && \
    cd openssl-${OPENSSL_VERSION} && \
    ./config no-shared no-ssl2 -fPIC --prefix=/openssl && \
    make && make install && \
    cd ..

# Build libffi from source
RUN curl -L -o libffi-${LIBFFI_VERSION}.tar.gz https://github.com/libffi/libffi/archive/v${LIBFFI_VERSION}.tar.gz && \
    tar xf libffi-${LIBFFI_VERSION}.tar.gz && \
    cd libffi-${LIBFFI_VERSION} && \
    ./autogen.sh && \
    ./configure --prefix=/libffi && \
    make && make install && \
    cd ..

# - Install extra build dependencies, if specified
# - Make sure we're using the latest version of setuptools
# - Make sure we're using the latest version of auditwheel
# - We only want to repair platform wheels that were compiled - not universal
#   wheels.
# - Add built wheels to lambda_function.zip
# - Add project-specific source/files to lambda_function.zip
# - Generate and add config.json to lambda_function.zip

# Before auditwheel:
#  ${PYBIN}/pip wheel --no-binary :all: -w /build_cache -r /dependencies/requirements.txt && \

# After auditwheel:
#    find /build_cache -type f \
#        -name "*.whl" \
#        -not -name "*none-any.whl" \
#        -exec auditwheel repair {} -w /build_cache/ \; \
#        -exec rm {} \; && \

CMD PYBIN="/opt/python/${PY_VERSION}/bin" && \
    set -ex && \
    if [[ -n "$EXTRA_PACKAGES" ]]; then yum install -y ${EXTRA_PACKAGES} ; else echo "no extra pkgs to install"; fi && \
    ${PYBIN}/pip install -U setuptools && \
    if [[ -n "$REBUILD_DEPENDENCIES" ]]; then \
        echo "rebuilding dependencies"; \
        ${PYBIN}/pip wheel --no-binary :all: -w /build_cache -r \
            /dependencies/requirements.txt && \
        sha1sum /dependencies/requirements.txt | \
            cut -d " " -f 1 > /build_cache/cache_version.sha1 ; \
    else echo "using cached dependencies; no rebuild" ; \
    fi && \
    ${PYBIN}/pip install -U auditwheel && \
    ${PYBIN}/pip install -t /install \
        --no-compile \
        --no-index \
        --find-links /build_cache \
        -r /dependencies/requirements.txt && \
    cd /install && \
        rm -f /dist/lambda_function.zip && \
        zip -r /dist/lambda_function.zip ./* && \
    cd /src && \
        zip -r /dist/lambda_function.zip ${INCLUDE} && \
    cd /tmp && \
        echo "{\"VERSION_HASH\": \"${VERSION_HASH}\", \"BUILD_TIME\": \"${BUILD_TIME}\"}" > config.json && \
        zip -r /dist/lambda_function.zip config.json
