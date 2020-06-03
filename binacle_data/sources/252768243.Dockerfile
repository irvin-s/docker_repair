FROM php:5.6-cli  
  
RUN \  
apt-get update && \  
apt-get install -y \  
git \  
vim  
  
RUN \  
git clone https://github.com/phacility/libphutil.git /opt/libphutil && \  
git clone https://github.com/phacility/arcanist.git /opt/arcanist  
  
RUN groupadd -r arcanist && useradd -m -r -g arcanist arcanist  
  
ENV PATH /opt/arcanist/bin/:$PATH  
  
VOLUME ["/app"]  
WORKDIR /app  
  
USER arcanist  
  
ENTRYPOINT ["/opt/arcanist/bin/arc"]  
CMD ["--help"]

