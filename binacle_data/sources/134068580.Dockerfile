FROM python:2.7
ADD . /code
WORKDIR /code
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD app.py app.py
CMD python app.py