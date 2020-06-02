FROM scorpil/rust:stable

RUN apt-get update && apt-get install -y libssl-dev file pkg-config build-essential
