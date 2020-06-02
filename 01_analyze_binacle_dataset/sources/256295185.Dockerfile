FROM scratch
COPY ./target/x86_64-unknown-linux-musl/release/api_proxy /ApiProxy/
VOLUME /ApiProxy/config
EXPOSE 6767
WORKDIR /ApiProxy
ENTRYPOINT ["/ApiProxy/api_proxy"]
