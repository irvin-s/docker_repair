FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "zmq"]
RUN ["pip", "install", "zmq"]
RUN ["pip", "install", "tornado"]
RUN ["pip", "install", "zmq"]
CMD ["python", "snippet.py"]