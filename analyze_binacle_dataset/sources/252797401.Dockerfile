FROM python:3-alpine  
  
LABEL maintainer "David Clutter<cluttered.code@gmail.com>"  
RUN apk update &&\  
apk upgrade &&\  
apk add \--no-cache \--virtual=build_deps g++ gfortran &&\  
pip install --no-cache-dir spacy &&\  
python -m spacy download en &&\  
apk del build_deps  

