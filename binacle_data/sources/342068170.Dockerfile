FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "cherrypy"]
CMD ["python", "snippet.py"]