FROM wpscanteam/wpscan  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
COPY src/server.rb /wpscan/server.rb  
  
ENTRYPOINT ["/wpscan/server.rb"]

