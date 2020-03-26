FROM python:2.7-alpine
LABEL maintainer "Mitja Felicijan <mitja.felicijan@gmail.com>"
WORKDIR /usr/src/app
COPY . .
CMD ["python", "./application.py"]
