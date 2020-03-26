FROM clojure  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN ["lein", "with-profile", "docker", "deps"]  
CMD ["lein", "with-profile", "docker", "run"]  
  

