FROM cyversewarwick/apples  
MAINTAINER Bo Gao <bogao@dcs.warwick.ac.uk>  
  
RUN cpanm Parallel::ForkManager  
RUN cpanm IPC::Shareable  
  
ADD . /apples  
  
ENTRYPOINT ["bash", "/apples/wrapper_de_rbh.sh"]

