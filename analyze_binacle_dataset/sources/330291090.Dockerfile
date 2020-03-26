FROM python:3.6-jessie
RUN mkdir /code
ADD requirements.txt /code
WORKDIR /code
RUN pip install -r requirements.txt
ADD . /code
CMD ["python", "crawler.py"]
