FROM ubuntu:14.04  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV PYTHON python python-scipy python-matplotlib python-scipy python-pil  
ENV PANDOC pandoc pandoc-citeproc  
ENV LATEX texlive texlive-latex-extra dvipng texlive-luatex texlive-xetex \  
texlive-lang-english texlive-lang-french  
  
RUN apt-get update && \  
apt-get install -y $PYTHON && \  
apt-get install -y $PANDOC && \  
apt-get install -y $LATEX && \  
rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove && \  
true  

