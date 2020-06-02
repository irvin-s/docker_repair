FROM ubuntu:xenial  
RUN mkdir -p /src \  
&& set -x \  
&& rm -f /etc/localtime \  
&& ln -s /usr/share/zoneinfo/Japan /etc/localtime \  
&& echo 'export TERM=xterm' >> /root/.bashrc \  
&& echo 'export TZ=JST-9' >> /root/.bashrc \  
&& buildDeps=' \  
' \  
&& tools=' \  
ca-certificates \  
vim \  
inetutils-ping \  
dnsutils \  
less \  
wget \  
curl \  
default-jdk \  
lsof \  
' \  
&& runtimes=' \  
' \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $buildDeps $tools $runtimes \  
&& rm -r /var/lib/apt/lists/* \  
\  
&& cd /src \  
&& wget ftp://ftp.riken.jp/net/apache/lucene/solr/7.1.0/solr-7.1.0.tgz \  
&& tar xf solr-7.1.0.tgz \  
&& solr-7.1.0/bin/install_solr_service.sh /src/solr-7.1.0.tgz \  
\  
&& cd / && rm -rf /src \  
\  
&& apt-get purge -y --auto-remove $buildDeps  
EXPOSE 8983  
COPY run.sh /usr/local/bin/  
CMD ["/usr/local/bin/run.sh"]  

