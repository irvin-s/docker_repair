FROM dockerfile/ubuntu

RUN curl -sO https://static.rust-lang.org/rustup.sh
RUN bash rustup.sh
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

VOLUME ["/src"]
WORKDIR /src
