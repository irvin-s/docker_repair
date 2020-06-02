FROM debian:jessie  
  
MAINTAINER Marcel Brand <marcel.brand@achtachtel.de>  
  
# Run update and install doxxygen and graphviz  
RUN apt-get update && apt-get install -y \  
doxygen \  
graphviz

