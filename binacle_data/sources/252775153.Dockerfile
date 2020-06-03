FROM alpine:3.7  
RUN apk --update add rust cargo gcc openssl-dev  
  
# cache crates.io index  
RUN cargo search std  

