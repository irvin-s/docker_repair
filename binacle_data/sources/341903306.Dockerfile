FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "falcon"]
RUN ["pip", "install", "requests"]
CMD ["python", "snippet.py"]