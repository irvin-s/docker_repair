from asciidoctor/docker-asciidoctor  
  
RUN gem install haml tilt  
  
ENV PREZ prez.adoc  
  
CMD asciidoctor -T ../asciidoctor-backends/haml $PREZ  

