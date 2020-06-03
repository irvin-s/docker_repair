FROM python:3.6

WORKDIR /app
COPY requirements.txt ./

RUN pip install \
    --no-cache-dir \
    -r requirements.txt

CMD ["python3", "src/main.py"]
