FROM elixir:latest  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
git \  
postgresql-client-9.4 \  
build-essential \  
erlang-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  

