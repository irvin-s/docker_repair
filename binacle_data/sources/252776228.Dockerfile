FROM python:3-alpine  
  
LABEL maintainer="Matthieu Boileau <matthieu.boileau@math.unistra.fr>"  
  
RUN pip install --no-cache-dir pelican markdown ipython nbconvert  
  

