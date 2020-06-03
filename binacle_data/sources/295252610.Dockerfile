FROM scorpil/rust:1.15
RUN mkdir -p /app/src
WORKDIR /app

# Copy manifest and lock file first to cache list of dependencies
COPY Cargo.* /app/

# Prefetch dependencies (requires creating an empty lib.rs to complete)
RUN touch src/lib.rs && cargo build

COPY src /app/src
RUN cargo build
CMD ["cargo", "test"]
