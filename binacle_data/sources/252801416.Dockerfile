FROM ubuntu:16.10  
  
RUN apt-get update && apt-get install -y \  
curl \  
build-essential \  
llvm-3.9-dev \  
libclang-3.9-dev \  
gcc-arm-none-eabi \  
libnewlib-arm-none-eabi \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \  
~/.cargo/bin/rustup show && \  
~/.cargo/bin/cargo install --git https://github.com/servo/rust-bindgen && \  
mv ~/.cargo/bin/bindgen /usr/bin/ && \  
rm -rf ~/.cargo ~/.rustup  

