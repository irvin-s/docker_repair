FROM docker.target.com/bat/sawtooth-build-agent-os

COPY . .

WORKDIR state_delta_subscriber

RUN rustup default nightly
RUN cargo build
