FROM debian:9 as builder

RUN apt-get update && \
    apt-get install -y curl libgmp-dev z3 libtinfo-dev && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    stack --version && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /work/bin
WORKDIR /work
COPY stack.yaml /work/
RUN stack setup
COPY package.yaml /work/
RUN stack build --only-dependencies
COPY . /work/
RUN stack install --local-bin-path ./bin

FROM debian:9
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc binutils clang make libmpich-dev mpich libgomp1 libomp5 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /work/bin/formura /usr/local/bin/

ENV LANG C.UTF-8
RUN mkdir /work && useradd -ms /bin/bash formura
USER formura
WORKDIR /work
CMD ["bash"]
