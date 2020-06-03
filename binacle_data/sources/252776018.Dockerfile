FROM tianon/latex  
  
RUN apt-get update && apt-get install -y \  
curl \  
rubber \  
&& rm -rf /var/lib/apt/lists/*  

