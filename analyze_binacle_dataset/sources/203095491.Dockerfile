FROM posborne/rust-cross:base

# Instal multilib so we can run i686 (in addition to x86_64) binaries
RUN apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends \
        gcc-multilib && \
    apt-get clean

# Consider adding targets as they become available as prebuilts
ENV RUST_TARGETS="x86_64-unknown-linux-gnu x86_64-unknown-linux-musl i686-unknown-linux-gnu"
RUN bash /rust-cross/install_rust.sh
