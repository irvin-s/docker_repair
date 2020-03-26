FROM lgarithm/crystalnet-dev:ubuntu

RUN apt install -y git
COPY . /crystalnet
WORKDIR /crystalnet
RUN ./utils/download-mnist.sh
RUN make install && \
    make test && \
    make python_example && \
    make go_example && \
    make check && \
    cloc src/crystalnet
