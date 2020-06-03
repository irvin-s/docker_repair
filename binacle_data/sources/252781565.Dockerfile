FROM python:3.5  
RUN pip install Flask Flask-Cache feedparser==5.2.1  
  
ADD mix.py mix.py  
ADD templates templates  
  
CMD python mix.py  
  

