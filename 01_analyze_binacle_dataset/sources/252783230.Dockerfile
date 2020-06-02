FROM dclong/jupyterlab-rstudio  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
libssl-dev \  
&& apt-get autoremove \  
&& apt-get autoclean  
  
RUN pip3 install \  
numpy scipy pandas dask \  
scikit-learn nltk tensorflow \  
matplotlib seaborn bokeh plotly \  
tabulate \  
JayDeBeApi pymongo sqlalchemy \  
Fabric3 ansible \  
pysocks \  
requests[socks] Scrapy beautifulsoup4 wget  
  
RUN jupyter labextension install jupyterlab_bokeh \  
&& jupyter lab build  
  
ENTRYPOINT ["/scripts/init.sh"]  

