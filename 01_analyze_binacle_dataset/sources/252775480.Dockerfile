# A Jupyter Notebook to play with data from the Koninklijke Bibliotheek  
FROM jupyter/notebook  
  
MAINTAINER Ben Companjen <ben@companjen.name>  
  
RUN apt-get update -qq && \  
DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \  
libxml2-dev \  
libxslt-dev && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ADD . /usr/src/kb-harvester  
  
RUN cd /usr/src/kb-harvester && python setup.py install  
  
CMD ["jupyter", "notebook", "--no-browser"]  

