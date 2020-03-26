FROM ubuntu:16.04  
  
MAINTAINER Caleb Johnson <me@calebj.io>  
  
LABEL io.calebj.project red-discordbot  
  
WORKDIR /opt/red/  
  
ARG repo=https://github.com/Twentysix26/Red-DiscordBot  
ARG branch=develop  
ENV RED_REPO=${repo} RED_BRANCH=${branch}  
  
ADD ${repo}/archive/${branch}.tar.gz /opt/red.tgz  
  
COPY reset_core_data.sh /bin/reset_core_data  
  
RUN mkdir -p /data/red && addgroup -gid 1000 red && \  
useradd -d /data/red -s /bin/bash -g 1000 -u 1000 red  
  
RUN tar xzf /opt/red.tgz --strip-components=1 && \  
mv cogs stock_cogs && mv data stock_data && \  
mkdir /data/red/cogs /data/red/data && \  
cp -rs /opt/red/stock_cogs/* /data/red/cogs/ && \  
cp -rs /opt/red/stock_data/* /data/red/data/ && \  
rm -rf /opt/red && mkdir /opt/red  
  
RUN chown -R red:red /data/red /opt/red  
  
VOLUME /data  

