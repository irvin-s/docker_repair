FROM python:3.6

ARG BUILD_VERSION

ENV PYTHONUNBUFFERED 1
ENV POSTGRES_PASSWORD 'secret'
ENV POSTGRES_USER 'url'
ENV POSTGRES_DB 'redirects'
ENV POSTGRES_HOST 'postgres'
ENV VERSION=$BUILD_VERSION

ADD . /opt/

WORKDIR /opt/

RUN pip install pipenv && pipenv install --system

EXPOSE 8000

CMD ["python", "app.py"]
