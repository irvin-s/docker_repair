FROM ecox/modelling-python:easter-weekly-forecast  
  
USER $NB_USER  
RUN pip install --upgrade pip && pip install sklearn-pandas  
  
RUN pip2 install --upgrade pip && pip2 install sklearn-pandas  
  

