FROM python:3  
RUN pip install --upgrade pip  
RUN pip install numpy  
  
ADD ./ /tmp/bsfpy  
ADD bsf-core/./ /tmp/bsfpy/bsf-core  
WORKDIR /tmp/bsfpy  
  
RUN python setup.py build_ext -DDEBUG -DBSF_AND install  

