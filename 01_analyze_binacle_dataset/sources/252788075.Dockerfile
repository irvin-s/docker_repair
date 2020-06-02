FROM crazycode/docbase  
MAINTAINER crazycode  
  
RUN pip install Sphinx && \  
pip install sphinx_rtd_theme && \  
pip install alabaster && \  
pip install sphinx_bootstrap_theme && \  
rm -rf /tmp/* /var/tmp/*  
  
CMD ["/bin/bash"]  

