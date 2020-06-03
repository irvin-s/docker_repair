# vim:set ft=dockerfile:  
FROM jimmycuadra/rust  
  
MAINTAINER Allan Simon <allan.simon@supinfo.com>  
WORKDIR /tmp  
  
RUN git clone https://github.com/allan-simon/rust-sinoparserd.git && \  
cd rust-sinoparserd && \  
cargo build  
  
COPY entrypoint.sh /tmp/entrypoint.sh  
RUN chown root:root /tmp/entrypoint.sh  
RUN chmod +x /tmp/entrypoint.sh  
  
EXPOSE 4000  
ENTRYPOINT ["/tmp/entrypoint.sh"]  

