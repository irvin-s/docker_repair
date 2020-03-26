FROM ubuntu:16.10  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update --quiet \  
&& apt-get dist-upgrade --yes \  
&& apt-get install --quiet --yes \  
build-essential \  
curl \  
git \  
pkg-config \  
libssl-dev  
  
RUN curl https://sh.rustup.rs > /tmp/rustup.sh \  
&& sh /tmp/rustup.sh -y \  
&& rm /tmp/rustup.sh \  
&& ln -s $HOME/.cargo/bin/rustc /usr/local/bin/rustc \  
&& ln -s $HOME/.cargo/bin/cargo /usr/local/bin/cargo  
  
RUN mkdir /rs  
COPY ./create-user.sh /rs/create-user.sh  
RUN chmod +x /rs/create-user.sh  
VOLUME /rs/data  
  
WORKDIR /rs  
  
RUN git clone https://github.com/untitaker/mysteryshack \  
&& cd mysteryshack \  
&& make \  
&& ln -s /rs/mysteryshack/target/release/mysteryshack /usr/local/bin/  
  
WORKDIR /rs/mysteryshack  
  
CMD mysteryshack -c /rs/config.ini serve  

