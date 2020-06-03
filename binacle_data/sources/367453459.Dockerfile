FROM python:${PYTHON_VERSION}

COPY test_project/requirements.txt /app/requirements.txt
WORKDIR /app/
RUN pip install -r requirements.txt

RUN pip install Django==${DJANGO_VERSION}

COPY . /externalliveserver
RUN pip install -e /externalliveserver

COPY test_project /app/
