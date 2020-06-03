FROM java:7  
MAINTAINER Sandro Athaide Coelho <sandroacoelho@gmail.com  
  
RUN apt-get update && apt-get install -y \  
curl \  
maven \  
git \  
bzip2  
  
RUN mkdir -p /mnt/dbpedia && \  
cd /mnt/dbpedia && \  
git clone https://github.com/sandroacoelho/lucene-quickstarter.git && \  
cd /mnt/dbpedia/lucene-quickstarter/dbpedia-spotlight && \  
mvn clean install  

