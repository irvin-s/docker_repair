FROM haskell:8  
  
COPY . /opt/net-fortune  
  
WORKDIR /opt/net-fortune  
  
RUN apt-get update && apt-get install xz-utils make  
RUN stack upgrade  
RUN stack build --test  
  
EXPOSE 8080  
ENTRYPOINT ["stack", "exec", "netFortune-exe"]

