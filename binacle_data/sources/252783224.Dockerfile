FROM dclong/jupyterhub  
  
RUN apt-get update \  
&& apt-get install -y openjdk-8-jdk  
  
RUN conda install -y -c conda-forge \  
numpy scipy pandas dask \  
tensorflow keras \  
gensim nltk \  
scikit-learn xgboost \  
matplotlib bokeh \  
tabulate \  
JayDeBeApi pymysql pymongo sqlalchemy sqlparse \  
pysocks \  
requests[socks] Scrapy beautifulsoup4 wget  
  
RUN conda install -y -c pytorch pytorch-cpu torchvision-cpu  
  
RUN conda install -y -c h2oai h2o  

