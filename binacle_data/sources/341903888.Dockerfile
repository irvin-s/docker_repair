FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "shapely"]
CMD ["python", "snippet.py"]