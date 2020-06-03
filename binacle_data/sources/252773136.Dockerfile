#  
# bnfnet/lede-openwrt  
#  
FROM ubuntu:14.04  
MAINTAINER docker@bnf.net  
ENV IMAGE=bnfnet/lede-openwrt \  
LEDEUSER=lede \  
LEDEDIR=/opt/lede  
  
RUN apt-get update && apt-get install -y \  
subversion \  
g++ \  
zlib1g-dev \  
build-essential \  
git \  
python \  
libncurses5-dev \  
gawk \  
gettext \  
unzip file \  
libssl-dev \  
wget  
  
RUN useradd -m ${LEDEUSER}  
  
RUN mkdir -p ${LEDEDIR} \  
&& chown ${LEDEUSER}:${LEDEUSER} ${LEDEDIR}  
  
USER ${LEDEUSER}  
WORKDIR ${LEDEDIR}  
RUN git clone https://git.lede-project.org/source.git ${LEDEDIR}  
RUN ./scripts/feeds update -a \  
&& ./scripts/feeds install -a  
  

