# This container builds the rumprun packages for hw/x86_64
FROM mato/rumprun-toolchain-hw-x86_64
MAINTAINER Martin Lucina <martin@lucina.net>

# Install additional build prerequisites.
RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -q -y \
        --no-install-recommends \
        autoconf                \
        automake                \
        cmake                   \
        curl                    \
        file                    \
        genisoimage             \
        libssl-dev              \
        makefs                  \
        python                  \
        python-dev              \
        python3                 \
        python3-dev             \
    && sudo apt-get clean

# List of packages we build. This will eventually just be "world".
# TODO erlang: does not build (see rumprun-packages issues)
# TODO rust: times out build
ENV BUILD_PACKAGES="mathopd hiawatha leveldb libxml2 pcre mpg123 nginx php ngircd redis mysql roundcube python3 nodejs"

# Build the packages, using as many CPUs as available.
RUN STDJ=$(cat /proc/cpuinfo | grep '^processor.*:' | wc -l) && \
    git clone https://github.com/rumpkernel/rumprun-packages && \
    cd /build/rumprun-packages && \
    echo "RUMPRUN_TOOLCHAIN_TUPLE=x86_64-rumprun-netbsd" > config.mk && \
    for pkg in ${BUILD_PACKAGES}; do make -j${STDJ} -C ${pkg} || exit 1; done

# XXX Need to do a make clean-world or similar here which removes the build
# trees and archives, but keeps the built unikernels.

# No sense to "docker run" this container.
CMD ["echo", "This is a CI container, nothing to run here!"]
