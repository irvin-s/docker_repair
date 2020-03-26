# Test container for CI/notification integration.
FROM mato/rumprun-toolchain-hw-x86_64
MAINTAINER Martin Lucina <martin@lucina.net>

# Build.
RUN x86_64-rumprun-netbsd-gcc -o hello hello.c && \
    rumprun-bake hw_virtio hello.bin hello

# No sense to "docker run" this container.
CMD ["echo", "This is a CI container, nothing to run here!"]
