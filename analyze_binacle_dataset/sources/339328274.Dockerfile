FROM python:2.7.15

WORKDIR app
COPY . .

ENTRYPOINT [ "python", "./main.py" ]
