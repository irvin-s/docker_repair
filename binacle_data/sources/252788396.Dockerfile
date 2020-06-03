# Event Data Event Bus Mock  
# Production build of Crossref Event Data Event Bus  
FROM clojure:lein-2.7.0-alpine  
MAINTAINER Joe Wass jwass@crossref.org  
  
COPY src /usr/src/app/src  
COPY test /usr/src/app/test  
COPY resources /usr/src/app/resources  
COPY project.clj /usr/src/app/project.clj  
  
WORKDIR /usr/src/app  
  
RUN lein deps && lein compile  

