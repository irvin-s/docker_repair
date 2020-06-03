# https://www.wihlidal.com/blog/pipeline/2018-09-15-linux-dxc-docker/
# https://www.wihlidal.com/blog/pipeline/2018-09-16-dxil-signing-post-compile/
# https://www.wihlidal.com/blog/pipeline/2018-09-17-linux-fxc-docker/
# https://www.wihlidal.com/blog/pipeline/2018-12-28-containerized_shader_compilers/

FROM gwihlidal/docker-shader:10

# Prevents annoying debconf errors during builds
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt update && apt install -y \
		# Required for service compilation
		build-essential \
		libssl-dev \
		pkg-config \
		curl \
	# Clean up
	&& apt autoremove -y \
	&& apt autoclean \
	&& apt clean \
	&& apt autoremove

# Install GCS Fuse
RUN apt-get update && apt-get install --yes --no-install-recommends \
		ca-certificates \
		curl \
	&& echo "deb http://packages.cloud.google.com/apt gcsfuse-bionic main" \
		| tee /etc/apt/sources.list.d/gcsfuse.list \
	&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
	&& apt-get update \
	&& apt-get install --yes gcsfuse \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /app

# Install Rust
WORKDIR /service
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Avoid having to install/build all dependencies when iterating
# by copying the Cargo files and making dummy main source files
COPY Cargo.* ./
RUN mkdir -p src/bin/compile && echo "fn main() {}" > src/bin/compile/main.rs && \
	mkdir -p src/bin/service && echo "fn main() {}" > src/bin/service/main.rs && \
	echo "fn fake() {}" > src/lib.rs && \
	echo "fn main() {}" > build.rs && \
	cargo build --release

# Add source files
COPY src src
COPY proto proto
COPY build.rs .

# We need to touch our real source files or
# else docker will use the cached ones.
RUN touch src/bin/compile/main.rs && \
	touch src/bin/service/main.rs && \
	touch src/lib.rs && \
	touch build.rs && \
	cargo build --release --color never && \
	mkdir -p /service/storage && \
	mkdir -p /service/temp

ENV STORAGE_PATH="/service/data/storage"
ENV TRANSFORM_PATH="/service/data/transform"
ENV TEMP_PATH="/service/temp"

RUN echo "" > service.env

EXPOSE 63999
ENTRYPOINT ["./target/release/service"]
#ENTRYPOINT ["/bin/bash"]