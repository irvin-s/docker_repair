# Event Data Evidence Logger  
# Production build of Crossref Evidence Logger  
FROM clojure:lein-2.7.0-alpine  
MAINTAINER Joe Wass jwass@crossref.org  
  
COPY src /usr/src/app/src  
COPY project.clj /usr/src/app/project.clj  
  
WORKDIR /usr/src/app  
  
RUN lein deps && lein compile  

