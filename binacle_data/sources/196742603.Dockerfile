
FROM python:3.4

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

EXPOSE 8000
CMD ["python", "/code/manage.py", "runserver", "0.0.0.0:8000"]