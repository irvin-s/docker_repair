FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "concurrent"]
RUN ["pip", "install", "asyncio"]
CMD ["python", "snippet.py"]