FROM ubuntu:xenial  
  
# Try replacing the standard ubuntu archive with a faster mirror  
RUN sed -i.bak 's/archive.ubuntu.com/mirrors.rit.edu/' /etc/apt/sources.list  
  
# Install Python3  
RUN apt-get update && apt-get install --assume-yes python3  
  
# Install LaTeX  
COPY install-texlive-without-docs.py /tmp/  
RUN python3 /tmp/install-texlive-without-docs.py  

