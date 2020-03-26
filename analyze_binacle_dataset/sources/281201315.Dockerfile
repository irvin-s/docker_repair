FROM python:2

COPY requirements-x86_64.txt ./
RUN pip install --no-cache-dir -r requirements-x86_64.txt

