FROM continuumio/anaconda  
  
RUN conda install django -y  
RUN pip install djangorestframework  
RUN pip install pymongo  
RUN conda install MySQL-python -y  
RUN conda install cx_oracle -y  
RUN apt-get install libaio1 libaio-dev -y  
  
EXPOSE 8000  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]  

