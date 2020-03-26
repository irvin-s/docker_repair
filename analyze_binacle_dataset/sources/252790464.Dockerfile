FROM careerlist/python-app:3.6-slim  
  
LABEL maintainer="careerlist"  
RUN mkdir -p /usr/share/man/man1 \  
&& mkdir -p /usr/share/man/man7 \  
&& apt-get update -y \  
&& apt-get install postgresql-client -y  

