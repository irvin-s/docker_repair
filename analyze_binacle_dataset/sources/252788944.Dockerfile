FROM debian  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
libmagickwand-dev \  
imagemagick \  
&& apt-get autoremove && rm -rf /var/lib/apt/lists/*  

