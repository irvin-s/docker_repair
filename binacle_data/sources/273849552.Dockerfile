FROM scratch

ADD target/x86_64-unknown-linux-musl/release/sentence-aligner /  
ENV ROCKET_PORT=80
ENV ROCKET_ADDRESS=0.0.0.0
EXPOSE 80

CMD ["/sentence-aligner"]  

