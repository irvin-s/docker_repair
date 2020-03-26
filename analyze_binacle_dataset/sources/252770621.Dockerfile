FROM python:latest  
  
Maintainer Joseph Herlant<herlantj@gmail.com>  
  
RUN apt update && apt install -y git vim-nox  
RUN pip install --upgrade --no-cache-dir pylint nose  
  
WORKDIR /usr/src/app  

