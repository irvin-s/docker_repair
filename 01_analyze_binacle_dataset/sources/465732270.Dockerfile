FROM python:3
WORKDIR /code
RUN pip install click
COPY . /code/
CMD ["python", "logger.py"]
