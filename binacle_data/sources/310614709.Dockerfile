FROM python:3

WORKDIR /usr/src/mds

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY . .

EXPOSE 8888

ENTRYPOINT ["python", "main.py"]