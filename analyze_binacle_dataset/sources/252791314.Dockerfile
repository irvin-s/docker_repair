FROM cyversewarwick/apples  
MAINTAINER Bo Gao <bogao@dcs.warwick.ac.uk>  
  
ADD . /apples  
  
ENTRYPOINT ["bash", "/apples/wrapper_de_utr.sh"]

