FROM calvintam236/ubuntu:nvidia  
  
MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>  
LABEL description="EWBF-Miner in Docker. Supports GPU mining."  
  
WORKDIR /tmp  
  
COPY ["Zec Miner 0.3.4b Linux Bin.tar.gz", "."]  
  
RUN tar -xf "Zec Miner 0.3.4b Linux Bin.tar.gz" \  
&& rm "Zec Miner 0.3.4b Linux Bin.tar.gz" \  
&& mv 0.3.4b/miner /usr/local/bin/ewbf-miner \  
&& chmod a+x /usr/local/bin/ewbf-miner \  
&& rm -r 0.3.4b \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}  
  
ENTRYPOINT ["ewbf-miner"]  
CMD ["--help"]  

