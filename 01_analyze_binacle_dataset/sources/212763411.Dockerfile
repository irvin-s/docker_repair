FROM python:2.7-alpine
RUN pip install bottle
ADD . /code
WORKDIR /code
EXPOSE 8000
CMD ["python", "app.py"]
