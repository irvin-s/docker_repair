FROM notder/docker-ruby-2.3.1-nodejs  
RUN apt-get update -q && apt-get install pandoc -yqq  
CMD ["bash"]  

