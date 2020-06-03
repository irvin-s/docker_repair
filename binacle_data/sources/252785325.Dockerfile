FROM debian:wheezy  
MAINTAINER Colin Densem "hello@summit360.co.uk"  
  
ENV DEBIAN_FRONTEND noninteractive  
# Add erlangsolutions key  
RUN apt-get update && \  
apt-get install -y wget locales ca-certificates && \  
localedef -i en_US -f UTF-8 en_US.UTF8 && \  
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \  
dpkg -i erlang-solutions_1.0_all.deb && \  
apt-get update && \  
apt-get install -y elixir && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV LANGUAGE en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  

