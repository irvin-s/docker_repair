FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "html5lib"]
RUN ["pip", "install", "xml"]
CMD ["python", "snippet.py"]