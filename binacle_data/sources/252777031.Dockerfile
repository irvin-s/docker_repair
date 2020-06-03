FROM cenote/xenial-base  
  
# Ubuntu release name  
ENV URELEASE xenial  
  
# Java and Java tools  
RUN apt-get update && apt-get install -y --no-install-recommends \  
ant \  
maven \  
openjdk-8-jdk-headless \  
&& rm -rf /var/lib/apt/lists/*  

