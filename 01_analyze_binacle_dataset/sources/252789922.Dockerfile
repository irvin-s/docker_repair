FROM debian:stretch-slim  
  
MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>  
LABEL description="Monero-Wallet-RPC in Docker."  
  
WORKDIR /tmp  
  
RUN apt-get update \  
&& apt-get -y --no-install-recommends install bzip2 ca-certificates curl \  
&& curl -L -O https://downloads.getmonero.org/cli/linux64 \  
&& tar -jxvf linux64 \  
&& rm linux64 \  
&& mv monero-*/monero-wallet-rpc /usr/local/bin/monero-wallet-rpc \  
&& chmod a+x /usr/local/bin/monero-wallet-rpc \  
&& rm -r monero-* \  
&& apt-get -y remove bzip2 ca-certificates curl \  
&& apt-get -y autoremove \  
&& apt-get clean autoclean \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}  
  
ENTRYPOINT ["monero-wallet-rpc"]  
CMD ["--help"]  

