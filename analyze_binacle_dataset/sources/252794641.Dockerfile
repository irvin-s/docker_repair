FROM ubuntu:xenial  
  
# Install dependencies  
RUN dpkg --add-architecture i386 \  
&& apt-get update -yq \  
&& apt-get install -yq --no-install-recommends \  
texlive-latex-base texlive-latex-extra texlive-fonts-recommended \  
lmodern make tree \  
&& rm -rf /var/lib/apt/lists/*  
# Add LaTeX build script  
ADD latex-build-all /usr/bin  
  

