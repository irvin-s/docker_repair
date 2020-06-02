FROM coocoocacha/nodejs-appengine  
  
ENV USER root  
ENV CARGO_HOME /app/.cargo  
ENV PATH $PATH:/app/.cargo/bin  
ENV RUST_ARCHIVE rust-nightly-x86_64-unknown-linux-gnu.tar.gz  
ENV RUST_DOWNLOAD_URL https://static.rust-lang.org/dist/$RUST_ARCHIVE  
  
COPY src/install_rust.sh /  
RUN /install_rust.sh  

