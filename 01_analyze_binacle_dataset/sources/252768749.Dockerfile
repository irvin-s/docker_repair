FROM debian:stretch  
  
RUN apt-get update -qq && apt-get install -qy haskell-stack zlib1g-dev  
RUN mkdir -p /pandoc  
WORKDIR /pandoc  
COPY stack* /pandoc/  
RUN stack setup  
COPY pandoc.cabal /pandoc/  
RUN stack install --only-dependencies  
COPY . /pandoc  
RUN stack install --flag pandoc:embed_data_files  
  
ENV PATH="/root/.local/bin:${PATH}"  
ENTRYPOINT ["/root/.local/bin/pandoc"]  

