# Dockerfile to build python3 images for constraint-based modeling  
# Based on Ubuntu  
# Add python3_scientific  
FROM dmccloskey/python3scientific:latest  
  
# File Author / Maintainer  
MAINTAINER Douglas McCloskey <dmccloskey87@gmail.com>  
  
# Switch to root for install  
USER root  
  
# Install wget  
RUN apt-get update -y && apt-get install -y \  
#wget \  
build-essential \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install glpk from http  
# instructions and documentation for glpk: http://www.gnu.org/software/glpk/  
WORKDIR /user/local/  
RUN wget http://ftp.gnu.org/gnu/glpk/glpk-4.57.tar.gz \  
&& tar -zxvf glpk-4.57.tar.gz  
  
WORKDIR /user/local/glpk-4.57  
RUN ./configure \  
&& make \  
&& make check \  
&& make install \  
&& make distclean \  
&& ldconfig \  
&& rm -rf /user/local/glpk-4.57.tar.gz  
  
# Install cobrapy, escher, and dependencies  
RUN apt-get update -y \  
&& apt-get install -y libxml2 \  
libxml2-dev \  
zlib1g \  
zlib1g-dev \  
bzip2 \  
libbz2-dev \  
libglpk-dev \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/* \  
&& apt-get clean  
  
# install python packages using pip3  
RUN pip3 install --no-cache-dir \  
#python-libsbml \  
"cobra[all]" \  
escher \  
&&pip3 install --upgrade  
  
# switch back to user  
WORKDIR $HOME  
USER user  
# set the command  
CMD ["python3"]  

