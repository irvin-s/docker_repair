FROM dclong/jupyterlab-rp  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
libssl-dev \  
unixodbc-dev \  
&& apt-get autoremove \  
&& apt-get autoclean  
  
RUN pip3 install \  
numpy scipy pandas dask \  
tensorflow keras scikit-learn nltk \  
matplotlib seaborn bokeh plotly \  
tabulate \  
JayDeBeApi pymongo sqlalchemy pyodbc \  
pysocks \  
requests[socks] Scrapy beautifulsoup4 wget  
  
RUN jupyter labextension install jupyterlab_bokeh \  
&& jupyter lab build  
  
ENTRYPOINT ["/scripts/init.sh"]  

