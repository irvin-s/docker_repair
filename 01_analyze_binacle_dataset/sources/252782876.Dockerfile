FROM python:3.6.4-slim  
LABEL maintainer="David Lemaitre"  
  
ENV SPHINX_VERSION 1.6.6  
ENV SPHINX_T3_THEME_VERSION 3.6.12  
# Install dependencies  
RUN apt-get update && apt-get install -y --no-install-recommends \  
make \  
latexmk \  
texlive-base \  
texlive-latex-recommended \  
texlive-latex-extra \  
texlive-fonts-recommended \  
texlive-latex-base \  
texlive-font-utils \  
texlive-lang-french \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install Python packages  
RUN pip install \  
sphinx=="$SPHINX_VERSION" \  
t3SphinxThemeRtd=="$SPHINX_T3_THEME_VERSION"  
  
WORKDIR /usr/src/app  

