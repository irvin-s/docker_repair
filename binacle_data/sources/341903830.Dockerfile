FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "xlsxwriter"]
RUN ["pip", "install", "pandas"]
CMD ["python", "snippet.py"]