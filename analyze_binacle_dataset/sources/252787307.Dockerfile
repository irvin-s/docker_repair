FROM brianp/muxedbuild-muxed  
MAINTAINER Brian Pearce  
  
RUN apt-get remove tmux && \  
apt-get install -qqy --no-install-recommends \  
autoconf \  
automake \  
m4 \  
libtool \  
perl \  
pkg-config \  
libevent-dev \  
ncurses-dev \  
locales  
  
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \  
echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \  
dpkg-reconfigure --frontend=noninteractive locales && \  
update-locale LANG=en_US.UTF-8  
  
ENV LANG en_US.UTF-8  
RUN git clone https://github.com/tmux/tmux.git tmux  
  
ENV PATH /root/tmux/bin:$PATH  
  
RUN rustup --version \  
&& rustc --version \  
&& cargo --version  

