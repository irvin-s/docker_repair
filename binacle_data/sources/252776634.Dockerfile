FROM elasticsearch:2.3  
MAINTAINER CathoLabs <catholabs@catho.com>  
  
# Install plugins  
RUN cd /usr/share/elasticsearch && \  
bin/plugin install license && \  
bin/plugin install marvel-agent && \  
bin/plugin install analysis-icu  

