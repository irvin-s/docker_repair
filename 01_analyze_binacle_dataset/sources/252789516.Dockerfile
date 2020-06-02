FROM pitkley/rust:nightly as build  
  
LABEL maintainer=maxim.vorobjov@gmail.com  
  
RUN apt-get update  
RUN apt-get install pkg-config libssl-dev -y  
  
RUN mkdir -p /rust/app  
WORKDIR /rust/app  
COPY . /rust/app  
  
RUN cargo build --release  
  
CMD ./target/release/poloniex  

