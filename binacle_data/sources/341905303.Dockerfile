FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "wikitools"]
CMD ["python", "snippet.py"]