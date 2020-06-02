FROM python:2
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "frontend.py"]
