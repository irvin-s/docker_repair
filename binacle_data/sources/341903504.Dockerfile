FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "nbformat"]
RUN ["pip", "install", "nbformat"]
CMD ["python", "snippet.py"]