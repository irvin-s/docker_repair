FROM debian:jessie  
  
RUN apt-get update  
  
RUN apt-get install -y pandoc  
RUN apt-get install -y texlive latex-beamer  
  
ENTRYPOINT ["pandoc"]

