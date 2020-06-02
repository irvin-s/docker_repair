FROM python:3.5

RUN pip install requests kubernetes; echo $PATH

COPY . .