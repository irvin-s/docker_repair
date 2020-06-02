#######################
# BUILD               #
#######################
# Base build of grin docker image

#use official rust docker image (debian based)
FROM rust:1.21-stretch as grin_build
#needs cmake
RUN apt-get update && apt-get -y install cmake clang
#checkout source fresh and build
WORKDIR /usr/src
RUN git clone https://github.com/mimblewimble/grin.git
WORKDIR /usr/src/grin
RUN cargo build

#######################
# DEPLOY              #
#######################
#Deploy binaries to a minimal image

FROM debian:stretch
#FROM rust:1.21-stretch
MAINTAINER yeastplume version:0.1
COPY --from=grin_build /usr/src/grin/target/debug/grin /usr/bin/grin
COPY --from=grin_build /usr/src/grin/target/debug/plugins/ /usr/lib/grin/plugins
RUN apt-get update && apt-get -y install curl
RUN useradd -m grinuser
COPY --from=grin_build /usr/src/grin/grin.toml /home/grinuser/.grin/grin.toml
RUN sed -i 's/.*cuckoo_miner_plugin_dir.*/cuckoo_miner_plugin_dir = "\/usr\/lib\/grin\/plugins"/g' /home/grinuser/.grin/grin.toml \
  && sed -i 's/.*file_log_level.*/file_log_level = "Trace"/g' /home/grinuser/.grin/grin.toml \
  && sed -i 's/.*api_http_addr.*/api_http_addr = "0.0.0.0:13413"/g' /home/grinuser/.grin/grin.toml \
  && sed -i 's/.*host.*=.*/host = "0.0.0.0"/g' /home/grinuser/.grin/grin.toml
#    && sed -i 's/.*mining_parameter_mode.*/mining_parameter_mode = "Production"/g' /home/grinuser/.grin/grin.toml
RUN chown -R grinuser:grinuser /home/grinuser/.grin
USER grinuser
WORKDIR /home/grinuser
ENV RUST_BACKTRACE=1
RUN grin wallet init
ENTRYPOINT ["/usr/bin/grin"]
# forward log to docker log collector
RUN ln -sf /dev/stdout /home/grinuser/grin.log
