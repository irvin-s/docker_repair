FROM wernight/phantomjs:2.1.1  
MAINTAINER Casper Chiang, casperchiang@chocolabs.com  
# chinese support  
USER root  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
fonts-arphic-uming \  
fonts-arphic-ukai \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
USER phantomjs  
  

