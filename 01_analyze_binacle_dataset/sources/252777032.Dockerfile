FROM cenote/xenial-base  
  
# Ubuntu release name  
ENV URELEASE xenial  
  
# Install Java9 first otherwise maven pulls in Java8 as dependency  
RUN apt-get update && apt-get install -y --no-install-recommends \  
openjdk-9-jdk-headless \  
&& rm -rf /var/lib/apt/lists/*  
# Java tools  
RUN apt-get update && apt-get install -y --no-install-recommends \  
ant \  
maven \  
&& rm -rf /var/lib/apt/lists/*

