FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "pycurl"]
RUN ["pip", "install", "BeautifulSoup"]
CMD ["python", "snippet.py"]