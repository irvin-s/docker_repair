FROM rethinkdb:2.3  
MAINTAINER Arve Knudsen <arve.knudsen@gmail.com>  
  
RUN apt-get update && \  
apt-get install -yq curl && \  
rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && \  
curl -L http://stedolan.github.io/jq/download/linux64/jq -o /usr/bin/jq && \  
chmod u+x /usr/bin/jq  
  
COPY ./run.sh /usr/bin/run.sh  
RUN chmod u+x /usr/bin/run.sh  
  
CMD "/usr/bin/run.sh"  

