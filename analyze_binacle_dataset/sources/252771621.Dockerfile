FROM python:2  
RUN pip install \  
jupyter \  
matplotlib \  
numpy \  
scipy \  
pandas \  
seaborn  
  
RUN mkdir -p /workdir /root/.jupyter /root/.ipython/profile_default  
COPY jupyter_notebook_config.py /root/.jupyter/  
COPY ipython_config.py /root/.ipython/profile_default/  
COPY demo.ipynb /workdir/  
COPY wrapper.py /wrapper.py  
WORKDIR /workdir  
VOLUME /workdir  
EXPOSE 80  
ENTRYPOINT ["python", "/wrapper.py"]  

