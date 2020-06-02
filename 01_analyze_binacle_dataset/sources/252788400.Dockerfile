# Event Data Live Demo  
FROM clojure:lein-2.7.0-alpine  
  
MAINTAINER Joe Wass jwass@crossref.org  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  

