FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "psycopg2"]
RUN ["pip", "install", "nagiosplugin"]
CMD ["python", "snippet.py"]