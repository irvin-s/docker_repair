FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "oauth2"]
RUN ["pip", "install", "simplejson"]
CMD ["python", "snippet.py"]