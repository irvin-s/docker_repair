FROM centos

RUN yum install -y tar gcc g++ openssl-devel openssl openssl-libs openssl-static

RUN gpg --keyserver pgp.mit.edu --recv-keys 7B3B09DC &>/dev/null && bash -c "gpg --import-ownertrust <(echo 108F66205EAEB0AAA8DD5E1C85AB96E6FA1BE5FE:6:)" &>/dev/null
RUN curl -s https://static.rust-lang.org/rustup.sh | sh -s -- --channel=nightly --date=2015-04-24 --disable-sudo --yes

ENV LD_LIBRARY_PATH /usr/local/lib

RUN mkdir /source

# Dependencies
COPY Cargo.toml /source/
COPY Cargo.lock /source/
RUN mkdir /source/src && echo "fn main() {}" > /source/src/main.rs
WORKDIR /source
RUN cargo build
RUN rm /source/src/main.rs

# actual source
VOLUME /source/src
