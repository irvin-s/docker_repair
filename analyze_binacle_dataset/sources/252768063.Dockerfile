FROM ubuntu:precise  
MAINTAINER adam.v.duke@gmail.com  
  
ENV RUBY_BUILD_DIR /tmp/ruby-build  
ENV RUBY_DESTDIR $RUBY_BUILD_DIR/dist  
ENV RUBY_PKG_VERSION 2.3  
ENV RUBY_VERSION 2.3.0  
ENV RUBY_PKG_ITERATION 1  
ENV RUBY_PKG_MAINTAINER adam.v.duke@gmail.com  
  
RUN apt-get update && apt-get upgrade -y libapt-pkg4.12  
RUN apt-get install -y wget \  
ca-certificates \  
build-essential \  
openssl \  
libreadline6 \  
libreadline6-dev \  
zlib1g \  
zlib1g-dev \  
libssl-dev \  
ncurses-dev \  
libyaml-dev \  
ruby-dev \  
gcc \  
ruby1.9.3  
  
RUN apt-get remove -y ruby1.8  
  
COPY build.sh $RUBY_BUILD_DIR/build.sh  
  
ENTRYPOINT ["/tmp/ruby-build/build.sh"]  

