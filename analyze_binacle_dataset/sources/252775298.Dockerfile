FROM beevelop/base  
  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
RUN apt-get update -qq && \  
apt-get install -y -q netbase hedgewars  
  
EXPOSE 46631  
  
CMD /usr/lib/hedgewars/bin/hedgewars-server -d True -p 46631  

