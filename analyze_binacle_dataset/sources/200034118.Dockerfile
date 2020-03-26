FROM python:3
ADD requirements.txt /requirements.txt
RUN pip install --upgrade -r requirements.txt
ADD indexer.py /indexer.py
CMD ["python", "indexer.py"]
