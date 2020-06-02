FROM ubuntu:14.04  
MAINTAINER Daniel Schierbeck <daniel.schierbeck@gmail.com>  
  
# Enable the universe package repository.  
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list  
  
RUN apt-get update  
RUN apt-get install -y ghc haskell-platform  
RUN cabal update  
  
WORKDIR /app  
  
ADD statsd.cabal /app/statsd.cabal  
RUN cabal install --only-dependencies  
RUN cabal configure  
  
ADD src /app/src  
RUN cabal build  
  
EXPOSE 8125/udp  
ENTRYPOINT ["/app/dist/build/statsd-server/statsd-server"]  

