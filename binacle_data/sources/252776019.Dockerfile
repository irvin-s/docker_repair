FROM tianon/latex  
  
RUN apt-get update && apt-get install -y \  
python-pygments \  
git \  
inkscape \  
&& rm -rf /var/lib/apt/lists/*  

