FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "autograd"]
RUN ["pip", "install", "autograd"]
RUN ["pip", "install", "autograd"]
RUN ["pip", "install", "autograd"]
CMD ["python", "snippet.py"]