FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "wagtail"]
RUN ["pip", "install", "django"]
CMD ["python", "snippet.py"]