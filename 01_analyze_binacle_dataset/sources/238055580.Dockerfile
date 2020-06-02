FROM ethcore/parity:beta-release
# Build failed, waiting for other jobs to finish...
# error: failed to run custom build command for `openssl-sys v0.9.3`
# process didn't exit successfully: `/tmp/parity/target/release/build/openssl-sys-29bf21276a352f83/build-script-build` (exit code: 101)

ENV VERSION=1.5.0
RUN cd /tmp ; curl --insecure -sL https://github.com/ethcore/parity/archive/v$VERSION.tar.gz | tar zx ; mv parity-$VERSION parity

RUN cd /tmp/parity && cargo build --release --verbose \
    && rustc -vV && cargo -V && gcc -v && g++ -v \
    && ls /build/parity/target/release/parity \
    && strip /build/parity/target/release/parity

RUN file /build/parity/target/release/parity
EXPOSE 8080 8545 8180
ENTRYPOINT ["/build/parity/target/release/parity"]
