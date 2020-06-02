FROM dimo414/base  
  
RUN apt-get update && apt-get install -y \  
mathpartir \  
texlive-fonts-recommended \  
texlive-latex-base \  
texlive-latex-extra \  
texlive-latex-recommended  
  
LABEL \  
version="0.1" \  
description="Image for TeX generation"

