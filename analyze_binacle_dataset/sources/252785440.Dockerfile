FROM colstrom/alpine  
  
RUN package install \  
bc \  
fish \  
groff \  
mdocml-apropos \  
util-linux  
  
ENTRYPOINT ["fish"]  

