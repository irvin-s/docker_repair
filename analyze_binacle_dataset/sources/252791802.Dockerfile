# damon/chess-engine  
#  
# v 0.1  
  
FROM debian:jessie  
  
# Install tcputils in order to use mini-inetd  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
build-essential \  
curl \  
tcputils && \  
rm -rf /var/lib/apt/lists/* && \  
apt-get clean && \  
apt-get autoremove -y  
  
# Download and install the stockfish engine  
RUN mkdir /tmp/stockfish && \  
cd /tmp/stockfish && \  
curl -SL "https://github.com/mcostalba/Stockfish/archive/master.tar.gz" | \  
tar zx --strip-components=1 && \  
cd src && \  
make profile-build ARCH=x86-64 && \  
make install && \  
cd / && rm -Rf /tmp/stockfish  
  
# Expose the mini-inetd port  
EXPOSE 8080  
  
CMD ["/usr/bin/mini-inetd", "-d", "8080", "/usr/local/bin/stockfish", "go"]  

