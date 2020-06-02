FROM python:2.7-alpine3.6

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY *.py .

CMD [ "python", "-m", "test", "-v"]
