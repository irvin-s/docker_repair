FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "numpy"]
RUN ["pip", "install", "arsenal"]
CMD ["python", "snippet.py"]