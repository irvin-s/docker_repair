# damon/nodejs  
FROM damon/base  
  
# Add the nodejs repo  
RUN add-apt-repository -y ppa:chris-lea/node.js && \  
apt-get update -qq && \  
DEBIAN_FRONTEND=noninteractive apt-get install -yqq nodejs  

