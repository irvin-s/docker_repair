FROM abernix/meteord:node-8.9.3-base  
  
RUN apt-get update && apt-get install -y \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*

