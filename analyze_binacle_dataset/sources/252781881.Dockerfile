FROM golang:onbuild  
MAINTAINER Christian Blades <christian.blades@careerbuilder.com>  
  
ADD https://www.gutenberg.org/cache/epub/48164/pg48164.txt /sample_text.txt  
  
EXPOSE 8080  

