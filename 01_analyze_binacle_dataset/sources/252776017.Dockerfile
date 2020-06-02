FROM tianon/latex  
  
RUN apt-get update && apt-get install -y \  
python-pygments \  
git \  
&& rm -rf /var/lib/apt/lists/*  

