FROM python:2.7
WORKDIR /app
RUN pip install flask
COPY . /app
EXPOSE 8000
ENTRYPOINT python main.py