FROM docker.target.com/bat/sawtooth-build-agent-os

COPY . .

WORKDIR processor
RUN cargo build
