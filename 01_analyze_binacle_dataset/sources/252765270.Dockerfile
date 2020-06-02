FROM python:3-slim  
  
RUN pip install sh  
RUN pip install pyyaml  
RUN pip install fn.py  
RUN pip install click  
RUN pip install mypy-lang  

