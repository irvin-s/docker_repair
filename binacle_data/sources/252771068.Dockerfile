# Docker image ahin017/report-openapitransform:toPdf  
# For executing 'toPdf' pipeline  
  
FROM ahin017/report-openapitransform:toHtml  
MAINTAINER Ashley Noel Hinton <ahin017@aucklanduni.ac.nz>  
  
# install pdflatex and texlive  
RUN apt-get update && apt-get install -y \  
texlive-latex-extra \  
texlive-latex-recommended \  
&& rm -rf /var/lib/apt/lists/*  

