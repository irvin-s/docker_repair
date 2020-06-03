# Pin to version of notebook image that includes start-singleuser.sh script  
FROM jupyter/scipy-notebook:2d878db5cbff  
  
# Install packages in default Python 3 environment  
RUN pip install \  
beautifulsoup4==4.4.*  
RUN pip install \  
bokeh==0.12.*  
  
# Install packages in Python 2 environment  
RUN $CONDA_DIR/envs/python2/bin/pip install \  
beautifulsoup4==4.4.*  
RUN $CONDA_DIR/envs/python2/bin/pip install \  
bokeh==0.12.*  
  
# Use custom startup script  
USER root  
COPY docker-entrypoint.sh /srv/docker-entrypoint.sh  
ENTRYPOINT ["tini", "--", "/srv/docker-entrypoint.sh"]  
CMD ["start-singleuser.sh"]  
  
USER jovyan  

