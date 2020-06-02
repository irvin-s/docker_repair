FROM ruby:2.1  
MAINTAINER Sven U. Frenzel <docker@frenzel.dk>  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
doxygen \  
graphviz \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN useradd --create-home --uid 1000 docker  
RUN chown -R docker:docker /home/docker  
USER docker  
  
WORKDIR /home/docker/  
  
CMD ["irb"]  

