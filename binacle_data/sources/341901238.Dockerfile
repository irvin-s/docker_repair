FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "pylab"]
RUN ["pip", "install", "numpy"]
RUN ["pip", "install", "scipy"]
CMD ["python", "snippet.py"]