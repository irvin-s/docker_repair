FROM rust:latest  
  
RUN mkdir /data  
WORKDIR /usr/src/paste-acm  
COPY . .  
  
RUN cargo install  
CMD ["paste-acm", "-d", "/data/paste-acm.db", "-vv"]  

