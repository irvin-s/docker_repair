FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "gym"]
RUN ["pip", "install", "matplotlib"]
RUN ["pip", "install", "numpy"]
CMD ["python", "snippet.py"]