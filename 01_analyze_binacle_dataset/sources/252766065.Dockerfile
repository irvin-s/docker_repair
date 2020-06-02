FROM java:8  
MAINTAINER a504082002 <a504082002@gmail.com>  
  
# Install dependencies  
RUN apt-get update -qq && \  
apt-get install -yq --no-install-recommends \  
git \  
less \  
python3 \  
libdatetime-perl \  
libxml-simple-perl \  
libdigest-md5-perl \  
bioperl \  
libgtextutils-dev \  
libgtextutils0 \  
libgd-graph-perl \  
libgd-text-perl \  
libperlio-gzip-perl \  
fastx-toolkit \  
ncbi-blast+ \  
roary && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# clone prokka  
RUN git clone https://github.com/tseemann/prokka.git && \  
prokka/bin/prokka --setupdb  
  
# set links to /usr/bin  
ENV PATH $PATH:/prokka/bin  
  
# set data mounting point  
VOLUME ["/input", "/output", "/data"]  
WORKDIR /data  
  
CMD ["/bin/bash"]  
  

