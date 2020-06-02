# This container builds the rumprun toolchain for hw/x86_64
FROM mato/rumprun-buildbase-debian
MAINTAINER Martin Lucina <martin@lucina.net>

# All builds are done as non-root.
USER build
WORKDIR /build

# Build and install the toolchain.
# This must be done in a single layer to avoid ballooning the image size,
# hence the series of "&&".
# It'd be nice if Docker had support for controlling when layers are created,
# wouldn't it? See
# http://jasonwilder.com/blog/2014/08/19/squashing-docker-images/ for possible
# solutions and https://github.com/docker/docker/issues/332 for bikeshed.
# DESTDIR specifies where the toolchain is installed in the container.
RUN DESTDIR=/usr/local && \
    BUILDRUMP_EXTRA= && \
    git clone https://github.com/rumpkernel/rumprun && \
    cd /build/rumprun && \
    git submodule init && git submodule update && \
    ./build-rr.sh -d $DESTDIR -o ./obj hw build -- $BUILDRUMP_EXTRA && \
    sudo ./build-rr.sh -d $DESTDIR -o ./obj hw install && \
    rm -rf /build/rumprun

# Install a "Hello, World" and build it to verify that the toolchain works.
COPY hello.c /build/
RUN x86_64-rumprun-netbsd-gcc -o hello hello.c && \
    rumprun-bake hw_virtio hello.bin hello && \
    rm -f hello.bin hello

# Install a welcome script to give the user a hint about what to do next.
# XXX Can't we just update .profile here and run a login shell?
COPY entrypoint.sh /build/
# XXX Docker Hub fails this with "chmod: changing permissions of '/build/entrypoint.sh: Operation not permitted"
# RUN chmod +x /build/entrypoint.sh
CMD ["/bin/bash", "/build/entrypoint.sh"]
