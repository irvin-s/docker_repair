FROM edpsciences/docker-texlive  
  
ADD texmf /usr/local/share/texmf  
RUN mktexlsr /usr/local/share/texmf  
  
RUN useradd -m writingstudio -u 1000  
  
USER writingstudio  
VOLUME /source  
WORKDIR /source  
  
ENTRYPOINT ["/usr/bin/latexmk"]  
  
CMD ["-pdf","output.tex"]  

