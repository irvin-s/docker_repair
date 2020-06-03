FROM python:2.7-alpine
RUN apk add --update gcc libffi-dev musl-dev openssl-dev python-dev
WORKDIR /src

COPY Pipfile pipenv.txt /src/
RUN pip install --disable-pip-version-check -r pipenv.txt
RUN pipenv install --system --skip-lock

COPY . /src
CMD pytest
