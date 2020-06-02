FROM cmbant/cosmobox:latest  
  
MAINTAINER Antony Lewis  
  
RUN git clone \--depth 10 https://github.com/cmbant/CAMB.git \  
&& cd CAMB \  
&& make \  
&& cd pycamb \  
&& python setup.py install \  
&& cd .. && make clean \  
&& cd ..  
  
RUN conda install --yes jupyter astropy statsmodels \  
&& pip install healpy starcluster \  
&& conda clean --yes -i -t -l -s -p && rm -Rf /root/.cache/pip  
  

