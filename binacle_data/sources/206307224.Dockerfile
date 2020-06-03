FROM python:3.6.3

COPY requirements.txt /tmp
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt

WORKDIR /tmp/python_skeleton

COPY . .
