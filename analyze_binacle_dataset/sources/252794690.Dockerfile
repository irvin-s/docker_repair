FROM debian:stretch  
  
MAINTAINER Yamada Yoseigi (datenarong@gmail.com)  
  
ENV DEBIAN_FRONTEND "noninteractive"  
# Install common linux application  
RUN apt-get update && \  
apt-get upgrade -yq --allow-downgrades && \  
apt-get install -y locales && \  
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8  
  
ENV LANG en_US.utf8  
  
# Install other application  
RUN apt-get update && \  
apt-get remove apt-listchanges && \  
apt-get install -yq --allow-downgrades --no-install-recommends \  
ca-certificates \  
curl \  
g++ \  
git \  
less \  
nano \  
make \  
rename \  
vim  
  
RUN set -xe; \  
\  
fetchDeps=' \  
wget \  
'; \  
if ! command -v gpg > /dev/null; then \  
fetchDeps="$fetchDeps \  
dirmngr \  
gnupg2 \  
"; \  
fi; \  
apt-get update; \  
apt-get install -y --no-install-recommends $fetchDeps; \  
rm -rf /var/lib/apt/lists/*;  
  
# Clean cash  
RUN rm -rf /var/lib/apt/lists/* && \  
apt-get -y clean

