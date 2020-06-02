FROM ubuntu:14.04
MAINTAINER Nat Lownes <nat.lownes@gmail.com>

RUN apt-get update --fix-missing -qq -y \
  && apt-get install -y \
    texlive-latex-base \
    texlive-xetex \ 
    latex-xcolor \ 
    texlive-math-extra \
    texlive-latex-extra \
    texlive-fonts-extra \
    curl \
    wget \  
    git \
    fontconfig \ 
    make \ 
    uuid-runtime \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


ADD process.bash /root/
RUN chmod +x /root/process.bash

ENTRYPOINT /root/process.bash -
