FROM calvintam236/ubuntu:nvidia  
  
MAINTAINER calvintam236 <calvintam236@users.noreply.github.com>  
LABEL description="ZM in Docker. Supports GPU mining."  
  
WORKDIR /tmp  
  
COPY ["zm_0.6.tar.gz", "."]  
  
RUN tar -xf zm_0.6.tar.gz \  
&& rm zm_0.6.tar.gz \  
&& mv zm_0.6/zm /usr/local/bin/zm \  
&& chmod a+x /usr/local/bin/zm \  
&& rm -r zm_0.6 \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}  
  
ENTRYPOINT ["zm"]  
CMD ["--help"]  

