FROM cyversewarwick/apples  
MAINTAINER Bo Gao <bogao@dcs.warwick.ac.uk>  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
psmisc \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD . /apples  
  
ENTRYPOINT ["bash", "/apples/wrapper_de_conservation.sh"]

