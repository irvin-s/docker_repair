FROM ubuntu
MAINTAINER Philipp Moritz email: pcm@berkeley.edu
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential ca-certificates curl git wget nano unzip libzmq3-dev python2.7-dev python-pip
RUN pip install numpy cython
RUN pip install protobuf
RUN pip install psutil
ENV RUST_VERSION=1.8.0
RUN cd /tmp && \
	curl -sO https://static.rust-lang.org/dist/rust-nightly-x86_64-unknown-linux-gnu.tar.gz   && \
	tar -xvzf rust-nightly-x86_64-unknown-linux-gnu.tar.gz && \
	./rust-nightly-x86_64-unknown-linux-gnu/install.sh --without=rust-docs && \
	rm -rf \
    rust-$RUST_VERSION-x86_64-unknown-linux-gnu \
    rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
RUN cd ~ && \
	git clone https://github.com/pcmoritz/cprotobuf.git && \
	cd cprotobuf && \
	python setup.py install
RUN cd ~ && \
	wget https://github.com/amplab/orchestra/releases/download/v0.1alpha/orchestra.zip && \
	unzip orchestra.zip -d orchestra && \
	cd orchestra && \
	cargo build
RUN cd ~ && \
	cd orchestra/lib/orchpy/ && \
	python setup.py build
ENV PYTHONPATH=/root/orchestra/lib:/root/orchestra/lib/orchpy/build/lib.linux-x86_64-2.7:${PYTHONPATH}
ENV LD_LIBRARY_PATH=/root/orchestra/target/debug/:${LD_LIBRARY_PATH}

WORKDIR /root/orchestra
CMD ["cargo", "run", "7114", "7227", "7228"]
EXPOSE 7114 7227 7228
