FROM r-base:3.4.3  
  
RUN apt-get update \  
&& apt-get install -y \  
pandoc \  
texlive \  
texlive-latex-extra \  
texinfo \  
imagemagick \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN Rscript -e 'install.packages("bookdown")'  

