#  
# Runs Hugo static site generator as a compiler  
#  
FROM devopsdays/docker-hugo:v0.30.2  
MAINTAINER Matt Stratton <matt.stratton@gmail.com>  
  
WORKDIR /site  
ENV SITE_URL="http://docker.local:1313"  
CMD hugo --baseURL="${VIRTUAL_HOST}"  

