FROM debian:wheezy  
MAINTAINER Dan Richner  
  
# Update packages and install ruby  
RUN apt-get update && apt-get install -y ruby  
  
# Install latest fig2coreos  
RUN gem install fig2coreos  
  
VOLUME ["/config"]  
WORKDIR /config  
  
# Default run "fig2coreos --help"  
ENTRYPOINT ["/usr/local/bin/fig2coreos"]  
CMD ["--help"]

