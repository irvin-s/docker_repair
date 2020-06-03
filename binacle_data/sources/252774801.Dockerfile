FROM ubuntu:17.04  
LABEL maintainer="svetoslav@batchovski.de"  
  
RUN apt-get update --fix-missing -qq -y \  
&& apt-get install -y \  
texlive-latex-base \  
texlive-latex-extra \  
texlive-science \  
texlive-lang-german \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /work  
  
ENTRYPOINT ["pdflatex"]  

