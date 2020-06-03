FROM pditommaso/dkrbase  
MAINTAINER Maria Chatzou <mxatzou@gmail.com>  
  
  
RUN apt-get update -y --fix-missing && apt-get install -y \  
git \  
cmake \  
libargtable2-dev  
  
RUN wget https://github.com/stamatak/standard-RAxML/archive/v8.0.0.zip \  
&& unzip v8.0.0.zip \  
&& rm -rf v8.0.0.zip  
  
#  
# Compile RAxML  
# See https://github.com/stamatak/standard-RAxML  
#  
RUN cd standard-RAxML-8.0.0; \  
make -f Makefile.gcc; rm *.o; \  
mv raxmlHPC /usr/local/bin/  
  

