FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "argh"]
RUN ["pip", "install", "numpy"]
RUN ["pip", "install", "matplotlib"]
RUN ["pip", "install", "svmpy"]
RUN ["pip", "install", "matplotlib"]
CMD ["python", "snippet.py"]