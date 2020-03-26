FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --quiet --upgrade setuptools pip && \
    pip install --quiet --no-cache-dir -r requirements.txt || exit 1

COPY . .

RUN python setup.py test || exit 1
